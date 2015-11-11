//
//  GBCData.m
//  phoneAssistant
//
//  Created by Denny_cheng on 15/9/8.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import "GBCChatDataModel.h"

@implementation GBCChatDataModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.name = dict[@"name"];
        self.icon = dict[@"icon"];
    }
    return self;
}

+(instancetype)chatWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
