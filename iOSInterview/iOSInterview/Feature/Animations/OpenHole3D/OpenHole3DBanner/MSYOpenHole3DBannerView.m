//
//  MSYOpenHole3DBannerView.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/2/22.
//

#import "MSYOpenHole3DBannerView.h"
#import <ZYBannerView/ZYBannerView.h>
#import <Masonry/Masonry.h>

#import "MSYOpenHole3DItemView.h"

@interface MSYOpenHole3DBannerView () <ZYBannerViewDataSource,ZYBannerViewDelegate>

@property (nonatomic, strong) ZYBannerView *bannerView;
@property (nonatomic, strong) MSYOpenHole3DItemView *currentItemView;

@end

@implementation MSYOpenHole3DBannerView

#pragma mark - lifecycle methods

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.bannerView];
        [self initConstraints];
    }
    return self;
}

#pragma mark - public methods

- (void)setBannerList:(NSArray<UIImage *> *)bannerList {
    _bannerList = bannerList;
    
    [self.bannerView reloadData];
}

- (void)updateGravityX:(double)gravityX
              gravityY:(double)gravityY {
    [self.currentItemView updateGravityX:gravityX
                                gravityY:gravityY];
}

#pragma mark - private methods

- (void)initConstraints {
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

#pragma mark - ZYBannerViewDataSource

// 返回Banner需要显示Item(View)的个数
- (NSInteger)numberOfItemsInBanner:(ZYBannerView *)banner
{
    return self.bannerList.count;
}

// 返回Banner在不同的index所要显示的View
- (UIView *)banner:(ZYBannerView *)banner viewForItemAtIndex:(NSInteger)index {
//    UIImage *image = self.bannerList[index];
    
    
    MSYOpenHole3DItemView *itemView = [[MSYOpenHole3DItemView alloc] init];
    itemView.frame = self.bounds;
    itemView.backImageView.image = [UIImage imageNamed:@"banner_back"];
    itemView.middleImageView.image = [UIImage imageNamed:@"banner_mid"];
    itemView.frontImageView.image = [UIImage imageNamed:@"banner_front"];
    self.currentItemView = itemView;

    return itemView;
}

#pragma mark - ZYBannerViewDelegate

- (void)banner:(ZYBannerView *)banner didSelectItemAtIndex:(NSInteger)index {
//    if ([_delegate respondsToSelector:@selector(homeHeaderView:didSelectItemAtIndex:)]) {
//        [_delegate homeHeaderView:self didSelectItemAtIndex:index];
//    }
}

- (void)banner:(ZYBannerView *)banner didScrollToItemAtIndex:(NSInteger)index {
//    if ([_delegate respondsToSelector:@selector(homeBannerView:didScrollToItemAtIndex:)]) {
//        [_delegate homeBannerView:self didScrollToItemAtIndex:index];
//    }
}

#pragma mark - getter && setter

- (ZYBannerView *)bannerView {
    if (!_bannerView) {
        _bannerView = [[ZYBannerView alloc] init];
        _bannerView.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _bannerView.pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        _bannerView.dataSource = self;
        _bannerView.delegate = self;
//        _bannerView.autoScroll = NO;
        _bannerView.shouldLoop = YES;
//        _bannerView.backgroundColor = [UIColor clearColor];
    }
    return _bannerView;
}

@end
