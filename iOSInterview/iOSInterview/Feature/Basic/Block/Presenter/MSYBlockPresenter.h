//
//  MSYBlockPresenter.h
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/10.
//

#import <MSYBaseClass/MSYBasePresenter.h>
#import "MSYBlockPresenterIO.h"
#import "MSYBlockDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface MSYBlockPresenter : MSYBasePresenter <MSYBlockPresenterInput>

@property (nonatomic, weak) id <MSYBlockPresenterOutput>output;

@end

NS_ASSUME_NONNULL_END
