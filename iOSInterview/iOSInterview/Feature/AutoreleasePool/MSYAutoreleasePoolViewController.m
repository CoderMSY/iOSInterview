//
//  MSYAutoreleasePoolViewController.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/2/7.
//  参考：https://www.jianshu.com/p/a2999d7728b4

#import "MSYAutoreleasePoolViewController.h"
#import "MSYCustomModel.h"

@interface MSYAutoreleasePoolViewController ()

@property (nonatomic, weak) NSString *referenceStr;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation MSYAutoreleasePoolViewController

#pragma mark - lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataSource = [NSMutableArray array];
    
    NSString *str;
//    @autoreleasepool {
        str = [NSString stringWithFormat:@"hello world"];
//    }
    
    self.referenceStr = str;
    NSLog(@"%s referenceStr:%@", __func__, self.referenceStr);//hello world
//    [self test];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    /* http://blog.sunnyxx.com/2014/10/15/behind-autorelease/
     viewDidLoad和viewWillAppear是在同一个runloop调用的
     */
    NSLog(@"%s referenceStr:%@", __func__, self.referenceStr);//(null)
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"%s referenceStr:%@", __func__, self.referenceStr);//(null)
}

#pragma mark - touches

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%lu", (unsigned long)self.dataSource.count);
    NSLog(@"%@", self.dataSource);
}

#pragma mark - public methods

#pragma mark - private methods

- (void)test {
    NSInteger largeNumber = 1000;
    for (int i = 0; i < largeNumber; i++) {
        /*
         每次创建的临时对象，（系统的）自动释放池需要等线程执行下一次事件循环时才会清空释放，也就意味着新的（临时）对象不断产生
         结果造成内存持续上涨，所有对象都要等for循环结束才释放
         
         1.[NSString stringWithFormat:@"hello -%04d", i]方法创建的对象会加入到自动释放池里，对象的释放权交给了RunLoop 的释放池
         2.RunLoop 的释放池会等待Runloop即将进入睡眠或者即将退出的时候释放一次
         3.for循环中线程一直在做事情，Runloop不会进入睡眠
         链接：https://www.jianshu.com/p/a2999d7728b4
         
         @autoreleasepool：将创建的新对象放在新建的自动释放池里，而不是系统的主池里，
         减少内存峰值，在块的末尾回收这些临时对象
         */
        
        @autoreleasepool {
            MSYCustomModel *model = [[MSYCustomModel alloc] init];
            model.image = [UIImage imageNamed:@"avatar_male_large"];
            NSString *str = [NSString stringWithFormat:@"hello -%04d", i];
            
            
            
            str = [str stringByAppendingString:@" - world"];
            NSLog(@"%@", str);
            model.text = str;
            [self.dataSource addObject:model];
        }
    }
    NSLog(@"-------------------%s------------------------", __func__);
}

#pragma mark - getter && setter



@end
