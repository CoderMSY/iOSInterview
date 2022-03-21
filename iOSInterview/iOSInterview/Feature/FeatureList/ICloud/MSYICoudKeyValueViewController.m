//
//  MSYICoudKeyValueViewController.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/19.
//

#import "MSYICoudKeyValueViewController.h"
#import <Masonry/Masonry.h>
#import <MSYCategory/UIButton+MSYHelper.h>
#import <MSYCategory/UIView+MSYHelper.h>
#import <MSYCategory/UIView+MSYLoading.h>

@interface MSYICoudKeyValueViewController ()

@property (nonatomic, strong) UITextField *keyTF;
@property (nonatomic, strong) UITextField *valueTF;
@property (nonatomic, strong) UIButton *saveBtn;
@property (nonatomic, strong) UIButton *fetchBtn;

@end

@implementation MSYICoudKeyValueViewController

#pragma mark - lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNotification];
    [self initSubview];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - public methods

#pragma mark - private methods

- (void)initSubview {
    [self.view addSubview:self.keyTF];
    [self.view addSubview:self.valueTF];
    [self.view addSubview:self.saveBtn];
    [self.view addSubview:self.fetchBtn];
    
    CGFloat safeAreaTop = [UIView msy_getSafeAreaTop];
    [self.keyTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(safeAreaTop + 50);
        make.leading.mas_equalTo(self.view).offset(30);
        make.trailing.mas_equalTo(self.view).offset(-30);
        make.height.mas_equalTo(40);
    }];
    [self.valueTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.keyTF.mas_bottom).offset(30);
        make.leading.trailing.height.mas_equalTo(self.keyTF);
    }];
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.valueTF.mas_bottom).offset(30);
        make.leading.mas_equalTo(self.view).offset(50);
        make.trailing.mas_equalTo(self.view).offset(-50);
        make.height.mas_equalTo(44);
    }];
    [self.fetchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.saveBtn.mas_bottom).offset(30);
        make.leading.trailing.height.mas_equalTo(self.saveBtn);
    }];
    
}

- (void)addNotification {
    //监听字符串变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(storeDidChange:) name:NSUbiquitousKeyValueStoreDidChangeExternallyNotification object:[NSUbiquitousKeyValueStore defaultStore]];
}

- (void)storeDidChange:(NSUbiquitousKeyValueStore *)defaultStore {
    NSLog(@"%@",defaultStore);
}

- (void)saveBtnClicked:(UIButton *)sender {
    if (self.keyTF.text.length == 0) {
        [self.view msy_postMessage:@"key不得为空"];
        return;
    }
    if (self.valueTF.text.length == 0) {
        [self.view msy_postMessage:@"value不得为空"];
        return;
    }
    
    
    NSUbiquitousKeyValueStore *store = [NSUbiquitousKeyValueStore defaultStore];
//    [store setObject:self.valueTF.text forKey:self.keyTF.text];
    [store setString:self.valueTF.text forKey:self.keyTF.text];
    [store synchronize];
    [self.view msy_postMessage:@"保存成功"];
}

- (void)fetchBtnClicked:(UIButton *)sender {
    if (self.keyTF.text.length == 0) {
        [self.view msy_postMessage:@"key不得为空"];
        return;
    }
    
    NSUbiquitousKeyValueStore *store = [NSUbiquitousKeyValueStore defaultStore];
    NSString *result = [store stringForKey:self.keyTF.text];
    
    if (result.length == 0) {
        [self.view msy_postMessage:@"查询结果为空"];
        return;
    }
    
    self.valueTF.text = result;
}

#pragma mark - getter && setter

- (UITextField *)keyTF {
    if (!_keyTF) {
        _keyTF = [[UITextField alloc] init];
        _keyTF.placeholder = @"请输入要保存或要查询的key";
    }
    return _keyTF;
}

- (UITextField *)valueTF {
    if (!_valueTF) {
        _valueTF = [[UITextField alloc] init];
        _valueTF.placeholder = @"请输入要保存的value";
    }
    return _valueTF;
}

- (UIButton *)saveBtn {
    if (!_saveBtn) {
        _saveBtn = [UIButton msy_buttonWithTarget:self action:@selector(saveBtnClicked:) titleFont:[UIFont systemFontOfSize:20] titleColor:[UIColor blueColor] title:@"保存"];
        _saveBtn.layer.cornerRadius = 5.0;
        _saveBtn.layer.borderWidth = 1.0;
        _saveBtn.layer.borderColor = [UIColor blueColor].CGColor;
    }
    return _saveBtn;
}

- (UIButton *)fetchBtn {
    if (!_fetchBtn) {
        _fetchBtn = [UIButton msy_buttonWithTarget:self action:@selector(fetchBtnClicked:) titleFont:[UIFont systemFontOfSize:20] titleColor:[UIColor brownColor] title:@"查询"];
        _fetchBtn.layer.cornerRadius = 5.0;
        _fetchBtn.layer.borderWidth = 1.0;
        _fetchBtn.layer.borderColor = [UIColor brownColor].CGColor;
    }
    return _fetchBtn;
}

@end
