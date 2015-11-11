//
//  GBCReviewDataModel.m
//  phoneAssistant
//
//  Created by Denny_cheng on 15/9/10.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import "GBCReviewDataModel.h"

@implementation GBCReviewDataModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.name=dict[@"name"];
        self.icon=dict[@"icon"];
        self.summary=dict[@"summary"];
    }
    return self;
}

+ (instancetype)ReviewWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}





@end
