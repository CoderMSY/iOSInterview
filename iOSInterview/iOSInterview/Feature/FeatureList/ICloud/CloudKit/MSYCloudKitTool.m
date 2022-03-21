//
//  MSYCloudKitTool.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/20.
//  参考:https://www.jianshu.com/p/e67ae6d792f3

#import "MSYCloudKitTool.h"
static NSString *const RECORD_TYPE_NAME = @"Person";

@implementation MSYCloudKitTool

//查询数据
+ (void)queryCloudKitDataComplete:(void(^)(NSArray<CKRecord *> * _Nullable results))complete {
    //获取位置
    CKContainer *container = [CKContainer defaultContainer];
    CKDatabase *database = container.publicCloudDatabase;
    
    //添加查询条件
//    NSPredicate *predicate = [NSPredicate predicateWithValue:YES];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title != %@", @"0"];
    CKQuery *query = [[CKQuery alloc] initWithRecordType:RECORD_TYPE_NAME predicate:predicate];
    
    NSSortDescriptor *sortDesc = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES];
    query.sortDescriptors = @[sortDesc];
    
    //开始查询
    [database performQuery:query inZoneWithID:nil completionHandler:^(NSArray<CKRecord *> * _Nullable results, NSError * _Nullable error) {
        
        NSLog(@"%@",results);
        if (error) {
            NSLog(@"%@ code:%ld", error.description, error.code);
        }
        else {
            if (complete) {
                complete(results);
            }
        }
    }];

}

+ (void)saveCloudKitModelWithTitle:(NSString *)title
                           content:(NSString *)content
                        photoImage:(UIImage * _Nullable)image
                          complete:(void(^ __nullable)(BOOL isSuccess))complete {
    CKContainer *container = [CKContainer defaultContainer];

    //公共数据
    CKDatabase *datebase = container.publicCloudDatabase;
//    //私有数据
//    CKDatabase *datebase = container.privateCloudDatabase;

    //创建主键
//    CKRecordID *noteID = [[CKRecordID alloc] initWithRecordName:@"NoteID"];
    
    //创建保存数据
    CKRecord *noteRecord = [[CKRecord alloc] initWithRecordType:RECORD_TYPE_NAME];
    
    if (image) {
        NSData *imageData = UIImagePNGRepresentation(image);
        if (imageData == nil) {
            imageData = UIImageJPEGRepresentation(image, 0.6);
        }
        NSString *tempPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/imagesTemp"];
        NSFileManager *manager = [NSFileManager defaultManager];
        if (![manager fileExistsAtPath:tempPath]) {
            
            [manager createDirectoryAtPath:tempPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        NSDate *dateID = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval timeInterval = [dateID timeIntervalSince1970] * 1000;      //*1000表示到毫秒级，这样可以保证不会同时生成两个同样的id
        NSString *idString = [NSString stringWithFormat:@"%.0f", timeInterval];

        NSString *filePath = [NSString stringWithFormat:@"%@/%@",tempPath,idString];
        NSURL *url = [NSURL fileURLWithPath:filePath];
        [imageData writeToURL:url atomically:YES];
        
        CKAsset *asset = [[CKAsset alloc]initWithFileURL:url];
        
        [noteRecord setValue:asset forKey:@"image"];
    }
    
    [noteRecord setValue:title forKey:@"title"];
    [noteRecord setValue:content forKey:@"content"];
    
    [datebase saveRecord:noteRecord completionHandler:^(CKRecord * _Nullable record, NSError * _Nullable error) {
        
        BOOL isSuccess;
        if (!error) {
            isSuccess = YES;
        }
        else {
            isSuccess = NO;
            NSLog(@"%@",error.description);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (complete) {
                complete(isSuccess);
            }
        });
        
    }];
}

//修改数据
+ (void)changeCloudKitWithTitle:(NSString *)title
                        content:(NSString *)content
                     photoImage:(UIImage *)image
                       recordID:(CKRecordID *)recordID
                       complete:(void(^ __nullable)(BOOL isSuccess))complete {
    //获取容器
    CKContainer *container = [CKContainer defaultContainer];
    //获取公有数据库
    CKDatabase *database = container.publicCloudDatabase;
    
    [database fetchRecordWithID:recordID completionHandler:^(CKRecord * _Nullable record, NSError * _Nullable error) {
        
        if (image) {
            NSData *imageData = UIImagePNGRepresentation(image);
            if (imageData == nil) {
                imageData = UIImageJPEGRepresentation(image, 0.6);
            }
            NSString *tempPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/imagesTemp"];
            NSFileManager *manager = [NSFileManager defaultManager];
            if (![manager fileExistsAtPath:tempPath]) {
                
                [manager createDirectoryAtPath:tempPath withIntermediateDirectories:YES attributes:nil error:nil];
            }
            
            NSDate *dateID = [NSDate dateWithTimeIntervalSinceNow:0];
            NSTimeInterval timeInterval = [dateID timeIntervalSince1970] * 1000;      //*1000表示到毫秒级，这样可以保证不会同时生成两个同样的id
            NSString *idString = [NSString stringWithFormat:@"%.0f", timeInterval];
            
            NSString *filePath = [NSString stringWithFormat:@"%@/%@",tempPath,idString];
            NSURL *url = [NSURL fileURLWithPath:filePath];
            [imageData writeToURL:url atomically:YES];
            
            CKAsset *asset = [[CKAsset alloc] initWithFileURL:url];
            [record setValue:asset forKey:@"photo"];
        }
        
        [record setObject:title forKey:@"title"];
        [record setObject:content forKey:@"content"];
        
        [database saveRecord:record completionHandler:^(CKRecord * _Nullable record, NSError * _Nullable error) {
            BOOL isSuccess;
            if (!error) {
                isSuccess = YES;
            }
            else {
                isSuccess = NO;
                NSLog(@"%@",error.description);
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (complete) {
                    complete(isSuccess);
                }
            });
        }];
    }];
}


@end
