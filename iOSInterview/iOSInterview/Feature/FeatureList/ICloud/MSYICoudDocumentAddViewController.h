//
//  MSYICoudDocumentAddViewController.h
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/19.
//

#import "MSYBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MSYICloudDocType) {
    MSYICloudDocType_add = 0,
    MSYICloudDocType_edit,
};

@interface MSYICoudDocumentAddViewController : MSYBaseViewController

@property (nonatomic, assign) MSYICloudDocType docType;
@property (nonatomic, strong) NSMetadataItem *metadataItem;

@end

NS_ASSUME_NONNULL_END
