//
//  SYCAppBaseResult.m
//  91助手
//
//  Created by sycjyy on 15/11/29.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCAppBaseResult.h"

#import "SYCAppBaseItem.h"
@implementation SYCAppBaseResult

+ (NSDictionary *)objectClassInArray{
    return @{@"items":[SYCAppBaseItem class]};
}
@end
