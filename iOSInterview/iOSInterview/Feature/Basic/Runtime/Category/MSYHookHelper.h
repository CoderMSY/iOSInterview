//
//  MSYHookHelper.h
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSYHookHelper : NSObject

+ (void)msy_swizzleInstanceWithClass:(Class)cls
                         originalSel:(SEL)originalSel
                         swizzledSel:(SEL)swizzledSel;

+ (void)msy_swizzleClassWithClass:(Class)cls
                      originalSel:(SEL)originalSel
                      swizzledSel:(SEL)swizzledSel;

@end

NS_ASSUME_NONNULL_END
