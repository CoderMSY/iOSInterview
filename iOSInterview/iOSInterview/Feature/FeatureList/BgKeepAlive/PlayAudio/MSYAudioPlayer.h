//
//  MSYAudioPlayer.h
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/1.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSYAudioPlayer : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, assign) BOOL needRunInBackground;
@property (nonatomic, strong) AVAudioPlayer *player;

@end

NS_ASSUME_NONNULL_END
