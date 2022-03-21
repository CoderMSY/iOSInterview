//
//  MSYDocument.m
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/20.
//

#import "MSYDocument.h"

@implementation MSYDocument

- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError *__autoreleasing  _Nullable *)outError {
    self.docData = [contents copy];
    
    return YES;
}

- (id)contentsForType:(NSString *)typeName error:(NSError *__autoreleasing  _Nullable *)outError {
    if (!self.docData) {
        self.docData = [[NSData alloc] init];
    }
    
    return self.docData;
}

@end
