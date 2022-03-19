//
//  MSYRuntimePresenter.m
//  iOSInterview
//
//  Created by Simon Miao on 2021/9/4.
//

#import "MSYRuntimePresenter.h"
#import <MSYTableView/MSYCommonTableData.h>
#import "MSYCommonTitleDetailCell.h"
#import "MSYCommonTitleDetailFrameModel.h"

@implementation MSYRuntimePresenter

#pragma mark - MSYRuntimePresenterInput

- (void)fetchDataSource {
    NSArray *sectionDicList = @[
        @{
            kSec_headerTitle : kSecRuntime_basic,
            kSec_rowContent : @[
                @{
                    kRow_title : kRowRuntime_what,
                    kRow_detailTitle : @"- OC是一门动态性比较强的编程语言，允许很多操作推迟到程序运行时再进行 \n- OC的动态性就是由Runtime来支撑和实现的，Runtime是一套C语言的API，封装了很多动态性相关的函数 \n- 平时编写的OC代码，底层都是转换成了Runtime API进行调用",
                },
                @{
                    kRow_title : kRowRuntime_dynamicCharacteristicsOfOC,
                    kRow_detailTitle : @"动态类型、动态绑定、动态加载 \n1.动态类型:动态类型是跟静态类型(int、NSString等)相对的。静态类型在 编译的时候就能被识别出来。而动态类型就编译器编译的时候是不能被识别的，要等到运行时(run time)，即程序运行的时候才会根据语境来识别。 \n2.动态绑定:对于其他一些静态语言，比如 c++,一般在编译的时候就已经将将要调用的函数的函数签名都告诉编译器了。而在OC中，函数调用就是给对象发送一条消息(“消息机制”)。OC可以先跳过编译，到运行的时候才动态地添加函数调用，在运行时才决定要调 用什么方法，需要传什么参数进去。这就是动态绑定，要实现他就必须用SEL变量绑定一个方法。 \n3.动态加载:根据需求加载所需要的资源，基本就是根据不同的机型做适配。最经典的例子就是在Retina设备上加载@2x的图片，而在老一些的普通屏设备上加载原图。",
                },
            ]
        },
        @{
            kSec_headerTitle : kSecRuntime_invoking,
            kSec_rowContent : @[
                @{
                    kRow_title : kRowRuntime_messageSending,
                    kRow_detailTitle : @"objc_msgSend(person, @selector(run)); \n消息发送阶段：\n消息的调用者，即消息的接收者receiver，根据isa指针，找到receiverClass父类中cache中查找，->再从receiverClass方法列表（class_rw_t）中查找 ->再分别通过receiverClass的superClass的cache、方法列表，依次向上父类中查找，如果一直无结果，则进入消息动态解析阶段；"
                },
                @{
                    kRow_title : kRowRuntime_dynamicMessageParsing,
                    kRow_detailTitle : @"消息动态解析：\n实例对象则调用resolveInstanceMethod，再此方法可通过class_getInstanceMethod创建方法，class_addMethod动态创建，如无动态解析，则进入消息转发阶段；",
                },
                @{
                    kRow_title : kRowRuntime_messageForwarding,
                },
            ]
        },
        @{
            kSec_headerTitle : kSecRuntime_class,
            kSec_rowContent : @[
                @{
                    kRow_title : kRowRuntime_class_allocateClassPair,
                },
                @{
                    kRow_title : kRowRuntime_class_registerClassPair,
                },
            ]
        },
        @{
            kSec_headerTitle : kSecRuntime_instance,
            kSec_rowContent : @[
                @{
                    kRow_title : kRowRuntime_instanceVariable,
                },
            ]
        },
        @{
            kSec_headerTitle : kSecRuntime_swizzleProblem,
            kSec_rowContent : @[
                @{
                    kRow_title : kRowRuntime_exchangeOnce,
                },
                @{
                    kRow_title : kRowRuntime_subclassIsNotImplAndSuperclassIsImpl,
                    kRow_detailTitle : @"-[MSYPerson doesNotRecognizeSelector:]:msy_studentInstanceMethod"
                },
                @{
                    kRow_title : kRowRuntime_subclassIsNotImplAndSuperclassIsNotImpl,
                    kRow_detailTitle : @"-[MSYPerson doesNotRecognizeSelector:]:personInstanceMethodIsNotImpl",
                },
                @{
                    kRow_title : kRowRuntime_class_subclassIsNotImplAndSuperclassIsImpl,
                },
                @{
                    kRow_title : kRowRuntime_class_subclassIsNotImplAndSuperclassIsNotImpl,
                }
            ]
        },
        @{
            kSec_headerTitle : kSecRuntime_apply,
            kSec_rowContent : @[
                @{
                    kRow_title : kRowRuntime_apply_ivar,
                },
                @{
                    kRow_title : kRowRuntime_apply_jsonToModel,
                },
                @{
                    kRow_title : kRowRuntime_apply_methodExchange,
                },
                @{
                    kRow_title : kRowRuntime_apply_array,
                }
            ]
        }
    ];
    NSMutableArray *sectionList = [NSMutableArray array];
    for (NSDictionary *sectionDic in sectionDicList) {
        NSMutableArray *rowList = [NSMutableArray array];
        NSArray *rowContentList = sectionDic[kSec_rowContent];
        for (NSDictionary *rowContent in rowContentList) {
            MSYCommonTitleDetailFrameModel *model = [[MSYCommonTitleDetailFrameModel alloc] init];
            model.title = rowContent[kRow_title];
            model.detail = rowContent[kRow_detailTitle];
            model.isNeedSelectStyle = YES;
            NSDictionary *rowDic = @{
                kRow_title : model.title ? : @"",
                kRow_extraInfo : model,
                kRow_rowHeight : @(model.cellHeight),
                kRow_cellClass : NSStringFromClass([MSYCommonTitleDetailCell class]),
            };
            [rowList addObject:rowDic];
        }
        NSDictionary *secDic =  @{
            kSec_headerTitle : sectionDic[kSec_headerTitle] ? : @"",
            kSec_rowContent :rowList,
            kSec_footerHeight : @(kSectionHeaderHeight_zero),
        };
        [sectionList addObject:secDic];
    }
    
    NSArray *dataSource = [MSYCommonTableSection sectionsWithData:sectionList];
    [(id<MSYRuntimePresenterOutput>)self.viewController renderDataSource:dataSource];
}

@end
