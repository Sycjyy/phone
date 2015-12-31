//
//  SYCCatebaseItem.m
//  91助手
//
//  Created by sycjyy on 15/12/11.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCCatebaseItem.h"

#import "SYCCateItem.h"
@implementation SYCCatebaseItem

+ (NSDictionary *)objectClassInArray{
    return @{@"listTags":[SYCCateItem class]};
}
@end
