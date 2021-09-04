//
//  MSYAlgorithmTool.m
//  iOSInterview
//
//  Created by Simon Miao on 2021/9/3.
//

#import "MSYAlgorithmTool.h"

@implementation MSYAlgorithmTool

#pragma mark - lifecycle methods


#pragma mark - public methods

void char_reverse1(char *cha) {
    char *begin = cha;
    char *end = cha + strlen(cha) - 1;
    while (begin < end) {
        char temp = *begin;
        *begin = *end;
        begin++;
        *end = temp;
        end--;
    }
    NSLog(@"%s", cha);
}

void char_reverse(char *cha) {
    char *begin = cha;
    char *end = cha + strlen(cha) - 1;
    while (begin < end) {
        char tmp = *begin;
        *(begin++) = *end;
        *(end--) = tmp;
        // i++ 返回的是+1前的i
        // ++i 返回的是+1后的i
    }
    
    NSLog(@"%s", cha);
}

void mergeSortedList(int aList[], int aListLen, int bList[], int bListLen, int result[]) {
    int a = 0; // 遍历数组aList的指针
    int b = 0; // 遍历数组bList的指针
    int i = 0; // 记录当前存储的位置
    
    while (a < aListLen && b < bListLen) {
        // 如果a数组对应位置的值小于b数组对应位置的值
        if (aList[a] <= bList[b]) {
            // 存储a数组的值
            result[i] = aList[a];
            // 移动a数组的遍历指针
            a++;
        }
        else {
            // 存储b数组的值
            result[i] = bList[b];
            // 移动b数组的遍历指针
            b++;
        }
        // 指向合并结果的下一个存储位置
        i++;
    }
    
    // 如果a数组有剩余
    while (a < aListLen) {
        // 将a数组剩余部分拼接到合并结果的后面
        result[i] = aList[a++];
        i++;
    }
    
    // 如果b数组有剩余
    while (b < bListLen) {
        // 将b数组剩余部分拼接到合并结果的后面
        result[i] = bList[b];
        b++;
        i++;
    }
}

+ (NSArray <UIView *> *)findCommonSuperView:(UIView *)viewOne
                                      other:(UIView *)viewOther {
    NSMutableArray *result = [NSMutableArray array];

    // 查找第一个视图的所有父视图
    NSArray *arrayOne = [self findSuperViews:viewOne];
    // 查找第二个视图的所有父视图
    NSArray *arrayOther = [self findSuperViews:viewOther];

    int i = 0;
    // 越界限制条件
    int minCount = MIN((int)arrayOne.count, (int)arrayOther.count);
    while (i < minCount) {
        // 倒序方式获取各个视图的父视图
        UIView *superOne = [arrayOne objectAtIndex:arrayOne.count - i - 1];
        UIView *superOther = [arrayOther objectAtIndex:arrayOther.count - i - 1];

        // 比较如果相等 则为共同父视图
        if (superOne == superOther) {
            [result addObject:superOne];
            i++;
        }
        // 如果不相等，则结束遍历
        else{
            break;
        }
    }
    return result;
}

// 排序 -  最中间的两个数
// 利用快排思想
// 随机选择 遍历 小 -- num=8 -- 大
// 集合 (n-1)/2
// 左侧<(n-1)/2 --- 中位数 -- 右侧的集合
int findMedianInUnorderedArray(int a[], int aLen) {
    int start = 0;
    int end = aLen - 1;
    
    int mid = (aLen - 1) / 2;
    int div = partSort(a, start, end);
    
    while (div != mid) {
        if (mid < div) {
            //左半区间找
            div = partSort(a, start, div - 1);
        }
        else {
            //右半区间找
            div = partSort(a, div + 1, end);
        }
    }
    
    //找到了
    for (int i = 0; i < aLen; i++) {
        NSLog(@"%d", a[i]);
    }
    return a[mid];
}
#pragma mark - private methods

+ (NSArray <UIView *> *)findSuperViews:(UIView *)view {
    // 初始化为第一父视图
    UIView *temp = view.superview;
    // 保存结果的数组
    NSMutableArray *result = [NSMutableArray array];
    while (temp) {
        [result addObject:temp];
        // 顺着superview指针一直向上查找
        temp = temp.superview;
    }
    return result;
}

int partSort(int a[], int start, int end) {
    int low = start;
    int high = end;
    
    //选取关键字
    int key = a[end];
    while (low < high) {
        //左边找比key小的值
        while (low < high && a[low] <= key)
        {
            ++low;
        }
        
        //右边找比key大的值
        while (low < high && a[high] >= key) {
            --high;
        }
        
        if (low < high) {
            //找到之后交换左右的值
            int temp = a[low];
            a[low] = a[high];
            a[high] = temp;
        }
    }
    
    int temp = a[high];
    a[high] = a[end];
    a[end] = temp;
    
    return low;
}

#pragma mark - getter && setter

@end
