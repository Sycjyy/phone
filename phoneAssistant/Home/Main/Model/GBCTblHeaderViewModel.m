//
//  GBCTblHeaderViewModel.m
//  phoneAssistant
//
//  Created by Denny_cheng on 15/9/10.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import "GBCTblHeaderViewModel.h"

@implementation GBCTblHeaderViewModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.LogoUrl=dict[@"LogoUrl"];
        self.Desc=dict[@"Desc"];
        self.TargetUrl=dict[@"TargetUrl"];
    }
    return self;
}

+ (instancetype)HeadWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
@end
