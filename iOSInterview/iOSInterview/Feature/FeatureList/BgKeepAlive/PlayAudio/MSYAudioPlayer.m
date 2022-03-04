//
//  MSYAudioPlayer.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/1.
//

#import "MSYAudioPlayer.h"

@implementation MSYAudioPlayer

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static MSYAudioPlayer *instance;
    dispatch_once(&onceToken, ^{
        instance = [[MSYAudioPlayer alloc] init];
    });
    
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initPlayer];
    }
    return self;
}

- (void)initPlayer {
    [self.player prepareToPlay];
}

- (AVAudioPlayer *)player {
    if (!_player) {
        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"SomethingJustLikeThis" withExtension:@"mp3"];
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
        _player.numberOfLoops = NSUIntegerMax;
    }
    return _player;
}

@end
