//
//  MSYICloudTool.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/20.
//

#import "MSYICloudTool.h"
#import "MSYDocument.h"

static NSString *const kICloudContainerId = @"iCloud.com.FancyPower.iOSInterview";

@implementation MSYICloudTool

#pragma mark - iCloud Document

//获取地址
+ (NSURL *)getUbiquityContainerURLWithFileName:(NSString *)fileName {
    NSURL *ubiquityURL = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:kICloudContainerId];
    //验证iCloud是否可用
    if(!ubiquityURL)
    {
        NSLog(@"尚未开启iCloud功能");
        return nil;
    }
    
    NSURL *URLWithFileName = [ubiquityURL URLByAppendingPathComponent:@"Documents"];
    URLWithFileName = [URLWithFileName URLByAppendingPathComponent:fileName];
    
    return URLWithFileName;
}

//创建文档
+ (void)createDocumentWithFileName:(NSString *)fileName
                           content:(NSString *)content
                          complete:(void(^ __nullable)(BOOL isSuccess))complete {
    NSURL *url = [self getUbiquityContainerURLWithFileName:fileName];
    MSYDocument *doc = [[MSYDocument alloc] initWithFileURL:url];
    
    NSString *docContent = content;
    doc.docData = [docContent dataUsingEncoding:NSUTF8StringEncoding];
    
    [doc saveToURL:url forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
        if (complete) {
            complete(success);
        }
    }];
}

//修改文档
+ (void)overwriteDocumentWithFileName:(NSString *)fileName
                              content:(NSString *)content
                             complete:(void(^ __nullable)(BOOL isSuccess))complete {
    NSURL *url = [self getUbiquityContainerURLWithFileName:fileName];
    MSYDocument *doc = [[MSYDocument alloc] initWithFileURL:url];
    
    doc.docData = [content dataUsingEncoding:NSUTF8StringEncoding];
    [doc saveToURL:url forSaveOperation:UIDocumentSaveForOverwriting completionHandler:^(BOOL success) {
        
        if (complete) {
            complete(success);
        }
    }];
}

//获取最新的数据
+ (void)getNewDocument:(NSMetadataQuery *)metadataQuery {
    [metadataQuery setSearchScopes:@[NSMetadataQueryUbiquitousDocumentsScope]];
    [metadataQuery startQuery];
}

@end
