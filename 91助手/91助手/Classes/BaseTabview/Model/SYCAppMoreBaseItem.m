//
//  SYCAppMoreBaseItem.m
//  91助手
//
//  Created by sycjyy on 15/12/3.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCAppMoreBaseItem.h"

#import "SYCAppBaseItem.h"
@implementation SYCAppMoreBaseItem

+ (NSDictionary *)objectClassInArray{
    return @{@"recommendSofts":[SYCAppBaseItem class]};
}

@end
