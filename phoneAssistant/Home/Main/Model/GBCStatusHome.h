//
//  GBCJptjModel.h
//  phoneAssistant
//
//  Created by Denny_cheng on 15/9/11.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBCStatusHome : NSObject
/**
 *  应用图片
 */
@property (nonatomic,copy)NSString *icon;
/**
 *  应用name
 */
@property (nonatomic,copy)NSString *name;
/**
 *  应用星级
 */
@property (nonatomic,assign)NSString *star;
/**
 *  下载次数描述
 */
@property (nonatomic,copy)NSString *downTimes;
/**
 *  应用大小
 */
@property(nonatomic,copy) NSString * size;
/**
 *  resId
 */
@property (nonatomic,copy) NSString *resId;
/**
 *  detailUrl
 */
@property (nonatomic,copy) NSString *detailUrl;
/**
 *  downAct
 */
@property (nonatomic,copy) NSString *downAct;
/**
 *  originalPrice
 */
@property (nonatomic,copy) NSString *originalPrice;
/**
 *  price
 */
@property (nonatomic,copy) NSString *price;
/**
 *  summary
 */
@property (nonatomic,copy) NSString *summary;
/**
 *  author
 */
@property (nonatomic,copy) NSString *author;
/**
 *  appType
 */
@property (nonatomic,copy) NSString *appType;
/**
 *  cataName
 */
@property (nonatomic,copy) NSString *cateName;
/**
 *  state
 */
@property (nonatomic,copy) NSString *state;



- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)statusWithDict:(NSDictionary *)dict;



@end
