//
//  MSYPlayAudioViewController.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/1.
//

#import "MSYPlayAudioViewController.h"
#import <Masonry/Masonry.h>
#import <MSYCategory/UIButton+MSYHelper.h>

#import "MSYAudioPlayer.h"

@interface MSYPlayAudioViewController ()

@property (nonatomic, strong) UIButton *playBtn;
//@property (nonatomic, strong) UIButton *pauseBtn;

@end

@implementation MSYPlayAudioViewController

#pragma mark - lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.playBtn];
//    [self.view addSubview:self.pauseBtn];
    [self initConstraints];
    
    [MSYAudioPlayer sharedInstance].needRunInBackground = YES;
}

#pragma mark - public methods

#pragma mark - private methods

- (void)initConstraints {
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view).offset(50);
        make.bottom.mas_equalTo(self.view.mas_centerY).offset(-20);
        make.trailing.mas_equalTo(self.view).offset(-50);
        make.height.mas_equalTo(50.0);
    }];
//    [self.pauseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.view.mas_centerY).offset(20);
//        make.leading.mas_equalTo(self.view).offset(50);
//        make.trailing.mas_equalTo(self.view).offset(-50);
//        make.height.mas_equalTo(50.0);
//    }];
}

- (void)playBtnClicked:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"播放"]) {
        [[MSYAudioPlayer sharedInstance].player play];
        [sender setTitle:@"暂停" forState:UIControlStateNormal];
    }
    else {
        [[MSYAudioPlayer sharedInstance].player pause];
        [sender setTitle:@"播放" forState:UIControlStateNormal];
    }
}

- (void)pauseBtnClicked:(UIButton *)sender {
    [[MSYAudioPlayer sharedInstance].player pause];
}

#pragma mark - getter && setter

- (UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton msy_buttonWithTarget:self action:@selector(playBtnClicked:) titleFont:[UIFont systemFontOfSize:17.0] titleColor:[UIColor blackColor] title:@"播放"];
        _playBtn.backgroundColor = [UIColor grayColor];
    }
    return _playBtn;
}

//- (UIButton *)pauseBtn {
//    if (!_pauseBtn) {
//        _pauseBtn = [UIButton msy_buttonWithTarget:self action:@selector(pauseBtnClicked:) titleFont:[UIFont systemFontOfSize:17.0] titleColor:[UIColor blackColor] title:@"暂停"];
//        _pauseBtn.backgroundColor = [UIColor grayColor];
//    }
//    return _pauseBtn;
//}

@end
