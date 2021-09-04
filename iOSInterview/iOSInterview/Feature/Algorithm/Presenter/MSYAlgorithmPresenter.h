//
//  MSYAlgorithmPresenter.h
//  iOSInterview
//
//  Created by Simon Miao on 2021/9/3.
//

#import <Foundation/Foundation.h>
#import "MSYAlgorithmPresenterIO.h"
#import "MSYAlgorithmDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface MSYAlgorithmPresenter : NSObject <MSYAlgorithmPresenterInput>

@property (nonatomic, weak) id <MSYAlgorithmPresenterOutput>output;

@end

NS_ASSUME_NONNULL_END
