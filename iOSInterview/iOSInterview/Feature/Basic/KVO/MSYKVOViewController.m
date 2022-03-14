//
//  MSYKVOViewController.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/11.
//

#import "MSYKVOViewController.h"
#import <objc/runtime.h>
#import "MSYKVOModel.h"

#import "MSYKVOListViewController.h"
#import "FBKVOListViewController.h"

@interface MSYKVOViewController ()

@property (nonatomic, strong) MSYKVOModel *person1;
@property (nonatomic, strong) MSYKVOModel *person2;

@end

@implementation MSYKVOViewController


#pragma mark - lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSubView];
    
    self.person1 = [[MSYKVOModel alloc] init];
    self.person1.age = 1;
    self.person1.height = 11;
    
    self.person2 = [[MSYKVOModel alloc] init];
    self.person2.age = 2;
    self.person2.height = 2;
    
    // 给person1对象添加KVO监听
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.person1 addObserver:self forKeyPath:NSStringFromSelector(@selector(age)) options:options context:@"123"];
    
    //添加KVO后，利用RuntimeAPI动态生成一个子类，并且让instance对象的isa指向这个全新的子类（此处为NSKVONotifying_MSYKVOModel）
    //打印：NSKVONotifying_MSYKVOModel setAge:, class, dealloc, _isKVOA,
    [self printMethodNamesOfClass:object_getClass(self.person1)];
    //打印：MSYKVOModel setAge:, age, setHeight:, height, willChangeValueForKey:, didChangeValueForKey:,
    [self printMethodNamesOfClass:object_getClass(self.person2)];
}

- (void)dealloc {
    //而iOS9 之后是weak引用关系，对象释放之后，指针也释放，不会崩溃
    
    [self.person1 removeObserver:self forKeyPath:NSStringFromSelector(@selector(age))];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // NSKVONotifying_MSYKVOModel是使用Runtime动态创建的一个类，是MSYKVOModel的子类
    // self.person1.isa == NSKVONotifying_MSYKVOModel
    
    self.person1.age = 20;
//    self.person2.age = 20;
}

#pragma mark - public methods

#pragma mark - private methods

- (void)initSubView {
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pushNextPage)];
    UIBarButtonItem *fbItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(pushFBPage)];
    self.navigationItem.rightBarButtonItems = @[rightItem, fbItem];
}

- (void)pushNextPage {
    MSYKVOListViewController *ctr = [[MSYKVOListViewController alloc] init];
    [self.navigationController pushViewController:ctr animated:YES];
}

- (void)pushFBPage {
    FBKVOListViewController *ctr = [[FBKVOListViewController alloc] init];
    [self.navigationController pushViewController:ctr animated:YES];
}

- (void)printMethodNamesOfClass:(Class)cls {
    unsigned int count;
    // 获得方法数组
    Method *methodList = class_copyMethodList(cls, &count);
    
    NSMutableString *methodNames = [NSMutableString string];
    
    for (int i = 0; i < count; i++) {
        Method method = methodList[i];
        NSString *methodName = NSStringFromSelector(method_getName(method));
        
        [methodNames appendString:methodName];
        [methodNames appendString:@", "];
    }
    
    free(methodList);
    
    NSLog(@"%@ %@", cls, methodNames);
}

#pragma mark - observe

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"keyPath:%@ object:%@ change:%@ context:%@", keyPath, object, change, context);
}

#pragma mark - getter && setter

@end
