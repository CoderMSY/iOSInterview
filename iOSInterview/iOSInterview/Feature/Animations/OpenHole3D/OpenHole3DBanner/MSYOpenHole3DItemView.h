//
//  MSYOpenHole3DItemView.h
//  iOSInterview
//
//  Created by Simon Miao on 2022/2/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSYOpenHole3DItemView : UIView

@property (nonatomic, strong, readonly) UIImageView *frontImageView;
@property (nonatomic, strong, readonly) UIImageView *middleImageView;
@property (nonatomic, strong, readonly) UIImageView *backImageView;

- (void)updateGravityX:(double)gravityX
              gravityY:(double)gravityY;

@end

NS_ASSUME_NONNULL_END
