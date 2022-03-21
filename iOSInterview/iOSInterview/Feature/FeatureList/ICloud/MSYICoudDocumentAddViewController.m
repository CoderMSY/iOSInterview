//
//  MSYICoudDocumentAddViewController.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/19.
//

#import "MSYICoudDocumentAddViewController.h"
#import <Masonry/Masonry.h>
#import <MSYCategory/UIView+MSYHelper.h>
#import <MSYCategory/UIView+MSYLoading.h>

#import "MSYICloudTool.h"
#import "MSYDocument.h"

@interface MSYICoudDocumentAddViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *fileNameTF;
@property (nonatomic, strong) UITextField *contentTF;
@property (nonatomic, copy) NSString *originalFileName;

@end

@implementation MSYICoudDocumentAddViewController

#pragma mark - lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.fileNameTF];
    [self.view addSubview:self.contentTF];
    [self initConstraints];
    [self createRightItem];
    
    if (MSYICloudDocType_edit == self.docType) {
        [self getDocContent];
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
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"save" style:UIBarButtonItemStylePlain target:self action:@selector(saveDoc:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)getDocContent {
    NSString *fileName = [self.metadataItem valueForAttribute:NSMetadataItemFSNameKey];
    self.originalFileName = fileName;
    self.fileNameTF.text = fileName;
    NSURL *fileUrl = [MSYICloudTool getUbiquityContainerURLWithFileName:fileName];
    MSYDocument *doc = [[MSYDocument alloc] initWithFileURL:fileUrl];
    [doc openWithCompletionHandler:^(BOOL success) {
        if (success) {
            NSString *docConten = [[NSString alloc] initWithData:doc.docData encoding:NSUTF8StringEncoding];
//            NSLog(@"%@",docConten);
            
            self.contentTF.text = docConten;
        }
        else {
            [self.view msy_postMessage:@"读取失败"];
        }
    }];
}

- (void)saveDoc:(UIBarButtonItem *)sender {
    if (self.fileNameTF.text.length == 0) {
        [self.view msy_postMessage:@"请输入标题"];
        
        return;
    }
    
    if (_docType == MSYICloudDocType_add) {
        NSString *fileName = [NSString stringWithFormat:@"%@.txt",self.fileNameTF.text];
        NSString *content = self.contentTF.text;
        [MSYICloudTool createDocumentWithFileName:fileName content:content complete:^(BOOL isSuccess) {
            if (isSuccess) {
                [self.view msy_postMessage:@"文档创建成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }
            else {
                [self.view msy_postMessage:@"文档创建失败"];
            }
        }];
    }
    else if (_docType == MSYICloudDocType_edit) {
        NSString *content = self.contentTF.text;
        [MSYICloudTool overwriteDocumentWithFileName:self.originalFileName content:content complete:^(BOOL isSuccess) {
            if (isSuccess) {
                [self.view msy_postMessage:@"文档修改成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }
            else {
                [self.view msy_postMessage:@"文档修改失败"];
            }
        }];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([textField isEqual:self.fileNameTF]) {
        if (MSYICloudDocType_edit == _docType) {
            return NO;
        }
    }
    
    return YES;
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
