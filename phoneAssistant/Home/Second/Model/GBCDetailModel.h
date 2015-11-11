//
//  GBCDetailModel.h
//  phoneAssistant
//
//  Created by Denny_cheng on 15/10/1.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBCDetailModel : NSObject
@property (nonatomic,assign) NSUInteger resId;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *identifier;
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *versionName;
@property (nonatomic,copy) NSString *versionCode;
@property (nonatomic,copy) NSString *cateName;
@property (nonatomic,copy) NSString *author;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,assign) NSUInteger star;
@property (nonatomic,copy) NSString *appbarUrl;
@property (nonatomic,copy) NSString *requirement;
@property (nonatomic,copy) NSString *lan;
@property (nonatomic,copy) NSString *desc;
@property (nonatomic,assign) NSUInteger size;
@property (nonatomic,assign) NSUInteger minFw;
@property (nonatomic,copy) NSString *downAct;
@property (nonatomic,copy) NSString *downTimes;
@property (nonatomic,copy) NSString *updateTime;
@property (nonatomic,copy) NSString *introReason;
@property (nonatomic,strong) NSArray *snapshots;
@property (nonatomic,strong) NSArray *recommendSofts;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)detailWithDict:(NSDictionary *)dict;


@end
