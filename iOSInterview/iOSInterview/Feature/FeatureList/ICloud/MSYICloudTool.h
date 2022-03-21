//
//  MSYICloudTool.h
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSYICloudTool : NSObject

+ (NSURL *)getUbiquityContainerURLWithFileName:(NSString *)fileName;
//创建文档
+ (void)createDocumentWithFileName:(NSString *)fileName
                           content:(NSString *)content
                          complete:(void(^ __nullable)(BOOL isSuccess))complete;
//修改文档
+ (void)overwriteDocumentWithFileName:(NSString *)fileName
                              content:(NSString *)content
                             complete:(void(^ __nullable)(BOOL isSuccess))complete;
//获取文档数据
+ (void)getNewDocument:(NSMetadataQuery *)metadataQuery;

@end

NS_ASSUME_NONNULL_END
