//
//  SYCHomeResult.m
//  91助手
//
//  Created by sycjyy on 15/11/29.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCHomeResult.h"

#import "SYCHomePart.h"
@implementation SYCHomeResult

+(NSDictionary *)objectClassInArray{
    return @{@"parts":[SYCHomePart class]};
}
@end
