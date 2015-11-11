//
//  GBCXsmfModel.m
//  phoneAssistant
//
//  Created by Denny_cheng on 15/9/11.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import "GBCHomeModel.h"

@implementation GBCHomeModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.name=dict[@"name"];
        self.uiType=dict[@"uiType"];
        self.act=dict[@"act"];
    }
    return self;
}
+ (instancetype)homeWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}


@end
