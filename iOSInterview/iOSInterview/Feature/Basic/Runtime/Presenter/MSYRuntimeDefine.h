//
//  MSYRuntimeDefine.h
//  iOSInterview
//
//  Created by Simon Miao on 2021/9/6.
//

#ifndef MSYRuntimeDefine_h
#define MSYRuntimeDefine_h


static NSString *const kSecRuntime_basic = @"runtime基本概念";
static NSString *const kRowRuntime_what = @"什么是runtime";
static NSString *const kRowRuntime_dynamicCharacteristicsOfOC = @"OC的动态特性";

static NSString *const kSecRuntime_invoking = @"函数调用";
static NSString *const kRowRuntime_messageSending = @"消息发送";
static NSString *const kRowRuntime_dynamicMessageParsing = @"动态方法解析";
static NSString *const kRowRuntime_messageForwarding = @"消息转发";

static NSString *const kSecRuntime_class = @"class method";
static NSString *const kRowRuntime_class_allocateClassPair = @"allocateClassPair";
static NSString *const kRowRuntime_class_registerClassPair = @"registerClassPair";

static NSString *const kSecRuntime_instance = @"instance variable method";
static NSString *const kRowRuntime_instanceVariable = @"instance variable method";

static NSString *const kSecRuntime_swizzleProblem = @"方法交换注意事项";
static NSString *const kRowRuntime_exchangeOnce = @"坑点1：方法交换一次性问题";
static NSString *const kRowRuntime_subclassIsNotImplAndSuperclassIsImpl = @"坑点2：子类没有实现，父类实现了";
static NSString *const kRowRuntime_subclassIsNotImplAndSuperclassIsNotImpl = @"坑点3：子类没有实现，父类也没有实现-crash";

static NSString *const kRowRuntime_class_subclassIsNotImplAndSuperclassIsImpl = @"类方法-子类没有实现，父类实现了";
static NSString *const kRowRuntime_class_subclassIsNotImplAndSuperclassIsNotImpl = @"类方法-子类没有实现，父类也没有实现-crash";

static NSString *const kSecRuntime_apply = @"runtime的应用";
static NSString *const kRowRuntime_apply_ivar = @"获取类的私有成员变量";
static NSString *const kRowRuntime_apply_jsonToModel = @"字典转模型";
static NSString *const kRowRuntime_apply_methodExchange = @"方法替换";
static NSString *const kRowRuntime_apply_array = @"防止数组越界";


#endif /* MSYRuntimeDefine_h */
