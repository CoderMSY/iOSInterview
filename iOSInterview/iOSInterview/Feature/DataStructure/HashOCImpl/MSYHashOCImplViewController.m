//
//  MSYHashOCImplViewController.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/2/24.
//

#import "MSYHashOCImplViewController.h"
#import "MSYHashTable.h"
#import "MSYSingleLinkedNode.h"

@interface MSYHashOCImplViewController ()

@end

@implementation MSYHashOCImplViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self test];
}

- (void)test {
    MSYHashTable *hashTable = [[MSYHashTable alloc]initWithCapacity:10];
    
    NSArray *dataList = @[
        @{@"key" : @"10", @"value" : @"1010"},
        @{@"key" : @"21", @"value" : @"1021"},
        @{@"key" : @"32", @"value" : @"1032"},
        @{@"key" : @"103", @"value" : @"1103"},
        @{@"key" : @"14", @"value" : @"1014"},
        @{@"key" : @"15", @"value" : @"1015"},
        @{@"key" : @"16", @"value" : @"1016"},
        @{@"key" : @"17", @"value" : @"1017"},
        @{@"key" : @"18", @"value" : @"1018"},
        @{@"key" : @"19", @"value" : @"1019"},
        @{@"key" : @"20", @"value" : @"1020"},
        @{@"key" : @"40", @"value" : @"1040"},
        @{@"key" : @"30", @"value" : @"1030"},
        @{@"key" : @"60", @"value" : @"1060"},
        @{@"key" : @"80", @"value" : @"1080"},
        @{@"key" : @"100", @"value" : @"1100"},
        @{@"key" : @"120", @"value" : @"1120"},
        @{@"key" : @"140", @"value" : @"1140"},
        @{@"key" : @"160", @"value" : @"1160"},
        @{@"key" : @"180", @"value" : @"1180"},
    ];
    
    NSLog(@"dataList count:%ld", dataList.count);
    for (NSDictionary *dic in dataList) {
        MSYSingleLinkedNode *node = [MSYSingleLinkedNode nodeWithKey:dic[@"key"] value:dic[@"value"]];
        [hashTable insertElementByNode:node];
    }
    
    NSString *value = [hashTable findElementByKey:@"60"];
    NSLog(@"获取key为60的值为=== %@", value);
    
    NSLog(@"插入的元素个数== %ld", hashTable.modCount);
    
    NSInteger index = 0;
    for (NSInteger i = 0; i < hashTable.elementArray.count; i ++) {
        id obj = [hashTable.elementArray objectAtIndex:i];
        if ([[obj class] isEqual:[MSYSingleLinkedNode class]]) {
            MSYSingleLinkedNode *currentNode = obj;
            while (currentNode != NULL) {
                NSLog(@"序号:%ld 循环次数:%ld----key:%@ value:%@", index, (long)i, currentNode.key, currentNode.value);
                currentNode = currentNode.next;
                
                index++;
            }
        }
    }
    NSLog(@"hashTable elementArray:%ld modCount:%ld", hashTable.elementArray.count, hashTable.modCount);
}

@end
