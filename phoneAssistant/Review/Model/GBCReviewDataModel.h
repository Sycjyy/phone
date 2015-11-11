//
//  GBCReviewDataModel.h
//  phoneAssistant
//
//  Created by Denny_cheng on 15/9/10.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBCReviewDataModel : NSObject
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *summary;
@property (nonatomic,copy)NSURL *icon;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)ReviewWithDict:(NSDictionary *)dict;

@end
