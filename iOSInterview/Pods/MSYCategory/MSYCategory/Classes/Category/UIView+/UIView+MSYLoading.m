//
//  UIView+MSYLoading.m
//
//
//  Created by SimonMiao on 2017/12/13.
//  Copyright © 2017年 Avatar. All rights reserved.
//

#import "UIView+MSYLoading.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <objc/runtime.h>

static const CGFloat KTipLoadingOverTime = 60;
static const CGFloat KTipNormalOverTime = 2;

@interface UIView (MSYLoadingView) <MBProgressHUDDelegate>

@property (nonatomic,strong) MBProgressHUD * progressHud;

@end

@implementation UIView (MSYLoadingView)

- (MBProgressHUD *)progressHud {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setProgressHud:(MBProgressHUD *)progressHud {
    return objc_setAssociatedObject(self, @selector(progressHud), progressHud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation UIView (MSYLoading)
    
#pragma mark - postLoading.

- (void)msy_postLoading
{
    [self msy_postLoadingWithTitle:nil];
}

- (void)msy_postLoadingWithTitle:(NSString *)title {
    [self msy_postLoadingWithTitle:title detail:nil];
}

- (void)msy_postLoadingWithTitle:(NSString *)title contentColor:(UIColor *)contentColor {
    [self msy_postLoadingWithTitle:title detail:nil];
//    self.progressHud.contentColor = contentColor;
    self.progressHud.detailsLabel.textColor = contentColor;
}

- (void)msy_postLoadingWithTitle:(NSString *)title detail:(NSString *)detail {
    [self msy_checkCreateHudLoading];
    
    if (title.length) {
        self.progressHud.label.text = title;
    }
    if (detail.length) {
        self.progressHud.detailsLabel.text = detail;
    }
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(overTimerCallback) object:nil];
    [self performSelector:@selector(overTimerCallback) withObject:nil afterDelay:KTipLoadingOverTime];
}


#pragma mark - postMessage

- (void)msy_postMessage:(NSString *)message {
    [self msy_postMessage:message duration:KTipNormalOverTime];
}

- (void)msy_postMessage:(NSString *)message duration:(NSTimeInterval)duration{
    [self msy_checkCreateHudLoading];
    [self msy_setTitle:message];
    // Set the text mode to show only text.
    self.progressHud.mode = MBProgressHUDModeText;
    // Move to bottm center.
    //    self.progressHud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    
    [self msy_hideLoadingWithAfterDelay:duration];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(overTimerCallback) object:nil];
    [self performSelector:@selector(overTimerCallback) withObject:nil afterDelay:duration];
}

- (void)msy_postMessageWithTitle:(NSString *)title detail:(NSString *)detail contentColor:(UIColor *)contentColor backgroundColor:(UIColor *)backgroundColor duration:(NSTimeInterval)duration {
    [self msy_checkCreateHudLoading];
    self.progressHud.mode = MBProgressHUDModeText;
    
    if (title.length) {
        self.progressHud.label.text = title;
    }
    if (detail.length) {
        self.progressHud.detailsLabel.text = detail;
    }
    if (contentColor) {
//        self.progressHud.contentColor = contentColor;
        self.progressHud.detailsLabel.textColor = contentColor;
    }
    if (backgroundColor) {
//        self.progressHud.label.superview.backgroundColor = backgroundColor;
        self.progressHud.backgroundColor = backgroundColor;
    }
    [self msy_hideLoadingWithAfterDelay:duration];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(overTimerCallback) object:nil];
    [self performSelector:@selector(overTimerCallback) withObject:nil afterDelay:duration];
}

- (void)msy_hideLoading {
    if (self.progressHud) {
        [self.progressHud hideAnimated:YES];
        [self.progressHud removeFromSuperview];
        self.progressHud.delegate = nil;
        self.progressHud = nil;
    }
}

- (void)msy_hideLoadingWithAfterDelay:(CGFloat)afterDelay {
    if (self.progressHud) {
        [self.progressHud hideAnimated:YES afterDelay:afterDelay];
    }
}

#pragma mark - private method

- (void)msy_checkCreateHudLoading
{
    if (!self.progressHud) {
        self.progressHud = [MBProgressHUD showHUDAddedTo:self animated:YES];
//        self.progressHud.bezelView.color = [UIColor blackColor];
//        self.progressHud.contentColor = [UIColor whiteColor];
        self.progressHud.detailsLabel.textColor = [UIColor whiteColor];
        self.progressHud.delegate = self;
    }
}

- (void)msy_setTitle:(NSString *)title {
    if ([title isKindOfClass:[NSNull class]]) {
        return;
    }
    if (title.length) {
        self.progressHud.label.text = title;
    }
}

- (void)overTimerCallback{
    [self msy_hideLoading];
}
    
#pragma mark - MBProgressHUDDelegate

- (void)hudWasHidden:(MBProgressHUD *)hud {
    if (self.progressHud) {
        [self.progressHud removeFromSuperview];
        self.progressHud.delegate = nil;
        self.progressHud = nil;
    }
}

@end
