//
//  MSYThreadDefine.h
//  iOSInterview
//
//  Created by Simon Miao on 2021/12/20.
//

#ifndef MSYThreadDefine_h
#define MSYThreadDefine_h

static NSString *const kThreadTitle_initThread = @"先创建线程，再启动线程";
static NSString *const kThreadTitle_detachNewThread = @"创建线程后自动启动线程";
static NSString *const kThreadTitle_performSelectorInBackground = @"隐式创建并启动线程";

static NSString *const kThreadTitle_downloadImage = @"线程通信案例";
static NSString *const kThreadTitle_threadSafe = @"NSThread 线程安全";

#endif /* MSYThreadDefine_h */
