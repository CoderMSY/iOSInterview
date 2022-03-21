//
//  MSYCloudKitAddViewController.h
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/20.
//

#import "MSYBaseViewController.h"
#import <CloudKit/CloudKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MSYCloudKitType) {
    MSYCloudKitType_add = 0,
    MSYCloudKitType_edit,
};

@interface MSYCloudKitAddViewController : MSYBaseViewController

@property (nonatomic, assign) MSYCloudKitType cloudKitType;
@property (nonatomic ,strong) CKRecordID            *recordID;

@end

NS_ASSUME_NONNULL_END
