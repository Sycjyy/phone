//
//  GBCData.h
//  phoneAssistant
//
//  Created by Denny_cheng on 15/9/8.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBCChatDataModel : NSObject
/**
 *  name模型
 */
@property (nonatomic,copy) NSString *name;
/**
 *  icon模型
 */
@property (nonatomic,copy) NSURL *icon;


- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)chatWithDict:(NSDictionary *)dict;
@end
