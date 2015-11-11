//
//  GBCJptjModel.m
//  phoneAssistant
//
//  Created by Denny_cheng on 15/9/11.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import "GBCStatusHome.h"

@implementation GBCStatusHome
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
//        self.icon=dict[@"icon"];
//        self.name=dict[@"name"];
//        self.star=dict[@"star"];
//        self.downTimes=dict[@"downTimes"];
//        self.size=dict[@"size"];
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)statusWithDict:(NSDictionary *)dict;
{
    return [[self alloc] initWithDict:dict];
}


@end
