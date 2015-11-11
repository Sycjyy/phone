//
//  GBCYyztModel.h
//  phoneAssistant
//
//  Created by Denny_cheng on 15/9/23.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBCYyztModel : NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *summary;
@property (nonatomic,copy) NSString *url;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)yyztWithDict:(NSDictionary *)dict;

@end
