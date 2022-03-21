//
//  MSYCloudKitAddViewController.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/20.
//

#import "MSYCloudKitAddViewController.h"
#import <Masonry/Masonry.h>
#import <MSYCategory/UIView+MSYHelper.h>
#import <MSYCategory/UIView+MSYLoading.h>

#import "MSYCloudKitTool.h"

@interface MSYCloudKitAddViewController ()

@property (nonatomic, strong) UITextField *fileNameTF;
@property (nonatomic, strong) UITextField *contentTF;

@end

@implementation MSYCloudKitAddViewController

#pragma mark - lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.fileNameTF];
    [self.view addSubview:self.contentTF];
    [self initConstraints];
    [self createRightItem];
    
    if (MSYCloudKitType_edit == self.cloudKitType) {
//        [self getDocContent];
    }
}

#pragma mark - public methods

#pragma mark - private methods

- (void)initConstraints {
    CGFloat safeAreaTop = [UIView msy_getSafeAreaTop] + 44.0;
    [self.fileNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(safeAreaTop + 15.0);
        make.leading.mas_equalTo(self.view).offset(30.0);
        make.trailing.mas_equalTo(self.view).offset(-30.0);
        make.height.mas_equalTo(44.0);
    }];
    [self.contentTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.fileNameTF.mas_bottom).offset(15.0);
        make.leading.mas_equalTo(self.view).offset(15.0);
        make.trailing.mas_equalTo(self.view).offset(-15.0);
        make.bottom.mas_equalTo(self.view.mas_centerY);
    }];
}

- (void)createRightItem {
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"save" style:UIBarButtonItemStylePlain target:self action:@selector(save:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)save:(UIBarButtonItem *)sender {
    if (self.fileNameTF.text.length == 0) {
        [self.view msy_postMessage:@"请输入标题"];
        
        return;
    }
    
    if (self.contentTF.text.length == 0) {
        [self.view msy_postMessage:@"请输入内容"];
        
        return;
    }
    
    if (MSYCloudKitType_add == _cloudKitType) {
        [MSYCloudKitTool saveCloudKitModelWithTitle:self.fileNameTF.text content:self.contentTF.text photoImage:nil complete:^(BOOL isSuccess) {
            if (isSuccess) {
                [self.view msy_postMessage:@"数据保存成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }
            else {
                [self.view msy_postMessage:@"数据保存失败"];
            }
        }];
    }
    else if (MSYCloudKitType_edit == _cloudKitType) {
        [MSYCloudKitTool changeCloudKitWithTitle:self.fileNameTF.text content:self.contentTF.text photoImage:nil recordID:self.recordID complete:^(BOOL isSuccess) {
            if (isSuccess) {
                [self.view msy_postMessage:@"数据保存成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }
            else {
                [self.view msy_postMessage:@"数据保存失败"];
            }
        }];
    }
}

#pragma mark - getter && setter


- (UITextField *)fileNameTF {
    if (!_fileNameTF) {
        _fileNameTF = [[UITextField alloc] init];
        _fileNameTF.placeholder = @"请输入文件名";
        _fileNameTF.delegate = self;
    }
    return _fileNameTF;
}

- (UITextField *)contentTF {
    if (!_contentTF) {
        _contentTF = [[UITextField alloc] init];
        _contentTF.placeholder = @"请输入正文";
        _contentTF.layer.cornerRadius = 5.0;
        _contentTF.layer.borderWidth = 1.0;
        _contentTF.layer.borderColor = [UIColor grayColor].CGColor;
    }
    return _contentTF;
}

@end
