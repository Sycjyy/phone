//
//  GBCSnapModel.h
//  phoneAssistant
//
//  Created by Denny_cheng on 15/10/1.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBCRecommendModel : NSObject
@property(nonatomic,assign) NSUInteger resId;
@property (nonatomic,copy) NSString *resName;
@property (nonatomic,copy) NSString *identifier;
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *detailUrl;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)detailWithDict:(NSDictionary *)dict;

@end
