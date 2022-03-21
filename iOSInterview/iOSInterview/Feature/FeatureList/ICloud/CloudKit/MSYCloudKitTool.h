//
//  MSYCloudKitTool.h
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/20.
//

#import <UIKit/UIKit.h>
#import <CloudKit/CloudKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSYCloudKitTool : NSObject

+ (void)queryCloudKitDataComplete:(void(^)(NSArray<CKRecord *> * _Nullable results))complete;

+ (void)saveCloudKitModelWithTitle:(NSString *)title
                           content:(NSString *)content
                        photoImage:(UIImage * _Nullable)image
                          complete:(void(^ __nullable)(BOOL isSuccess))complete;

+ (void)changeCloudKitWithTitle:(NSString *)title
                        content:(NSString *)content
                     photoImage:(UIImage * _Nullable)image
                       recordID:(CKRecordID *)recordID
                       complete:(void(^ __nullable)(BOOL isSuccess))complete;

@end

NS_ASSUME_NONNULL_END
