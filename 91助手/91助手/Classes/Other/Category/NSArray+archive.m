//
//  NSArray+archive.m
//  91助手
//
//  Created by sycjyy on 15/12/15.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//
#define SYCRecordBtnName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"recoraBtn"]

#import "NSArray+archive.h"

@implementation NSArray (archive)

static NSMutableArray *_recordBtn;
+ (void)saveWithObject:(NSMutableArray *)array{
    [NSKeyedArchiver archiveRootObject:array toFile:SYCRecordBtnName];
}

+ (NSMutableArray *)unArchiveArray{
    if (_recordBtn == nil) {
        _recordBtn = [NSKeyedUnarchiver unarchiveObjectWithFile:SYCRecordBtnName];
    }
    return _recordBtn;
}
@end
