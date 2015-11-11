//
//  GBCTblHeaderViewModel.h
//  phoneAssistant
//
//  Created by Denny_cheng on 15/9/10.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBCTblHeaderViewModel : NSObject
@property (nonatomic,copy)NSString *LogoUrl;
@property (nonatomic,copy)NSString *TargetUrl;
@property (nonatomic,copy)NSString *Desc;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)HeadWithDict:(NSDictionary *)dict;


@end
