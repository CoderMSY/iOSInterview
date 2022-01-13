//
//  MSYCollectionItemCell.h
//  iOSInterview
//
//  Created by Simon Miao on 2021/10/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSYCollectionItemCell : UICollectionViewCell

@property (nonatomic, copy) NSString *name;

+ (NSString *)cellReuseId;

@end

NS_ASSUME_NONNULL_END
