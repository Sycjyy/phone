//
//  SYCAppBaseResult.h
//  91助手
//
//  Created by sycjyy on 15/11/29.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MJExtension.h"
@interface SYCAppBaseResult : NSObject<MJKeyValue>

@property (nonatomic, copy)NSString *atLastPage;

@property (nonatomic, strong) NSArray *items;

//@property (nonatomic, strong) NSArray *Result;
@end
