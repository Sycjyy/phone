//
//  GBCSnapModel.m
//  phoneAssistant
//
//  Created by Denny_cheng on 15/10/1.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import "GBCRecommendModel.h"

@implementation GBCRecommendModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)detailWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
