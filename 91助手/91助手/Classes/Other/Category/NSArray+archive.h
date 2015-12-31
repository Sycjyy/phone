//
//  NSArray+archive.h
//  91助手
//
//  Created by sycjyy on 15/12/15.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (archive)


+ (void)saveWithObject:(NSMutableArray *)array;

+ (NSMutableArray *)unArchiveArray;
@end
