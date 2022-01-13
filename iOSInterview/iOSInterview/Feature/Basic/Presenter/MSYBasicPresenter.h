//
//  MSYBasicPresenter.h
//  iOSInterview
//
//  Created by Simon Miao on 2021/9/4.
//

#import <MSYBaseClass/MSYBasePresenter.h>
#import "MSYBasicPresenterIO.h"
#import "MSYBasicDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface MSYBasicPresenter : MSYBasePresenter <MSYBasicPresenterInput>

@property (nonatomic, strong) id <MSYBasicPresenterOutput>output;

@end

NS_ASSUME_NONNULL_END
