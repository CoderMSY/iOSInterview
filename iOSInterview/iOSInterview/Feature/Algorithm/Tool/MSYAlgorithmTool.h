//
//  MSYAlgorithmTool.h
//  iOSInterview
//
//  Created by Simon Miao on 2021/9/3.
//

#import <UIKit/UIKit.h>

//NS_ASSUME_NONNULL_BEGIN

@interface MSYAlgorithmTool : NSObject

/// 字符串逆序
/// @param cha 字符串指针
void char_reverse(char *cha);
/// 合并有序数组
void mergeSortedList(int aList[],
                     int aListLen,
                     int bList[],
                     int bListLen,
                     int result[]);

/// 查找两个视图的共同父视图
 + (NSArray<UIView *> *)findCommonSuperView:(UIView *)view other:(UIView *)viewOther;

// 无序数组中位数查找
int findMedianInUnorderedArray(int a[], int aLen);

@end

//NS_ASSUME_NONNULL_END
