//
//  GBCYyztModel.m
//  phoneAssistant
//
//  Created by Denny_cheng on 15/9/23.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import "GBCYyztModel.h"

@implementation GBCYyztModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.name=dict[@"name"];
        self.icon=dict[@"icon"];
        self.summary=dict[@"summary"];
        self.url=dict[@"url"];
    }
    return self;
}
+ (instancetype)yyztWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
