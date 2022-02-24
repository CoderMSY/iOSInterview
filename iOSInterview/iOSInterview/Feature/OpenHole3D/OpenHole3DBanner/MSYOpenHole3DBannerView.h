//
//  MSYOpenHole3DBannerView.h
//  iOSInterview
//
//  Created by Simon Miao on 2022/2/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSYOpenHole3DBannerView : UIView

@property (nonatomic, copy) NSArray <UIImage *>*bannerList;

- (void)updateGravityX:(double)gravityX
              gravityY:(double)gravityY;

@end

NS_ASSUME_NONNULL_END
