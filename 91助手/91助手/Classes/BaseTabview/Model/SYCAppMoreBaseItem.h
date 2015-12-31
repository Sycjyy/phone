//
//  SYCAppMoreBaseItem.h
//  91助手
//
//  Created by sycjyy on 15/12/3.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "MJExtension.h"
@interface SYCAppMoreBaseItem : NSObject<MJKeyValue>
/**
 *应用吧网址
 */
@property (nonatomic, copy)NSString *appbarUrl;
/**
 *app作者
 */
@property (nonatomic, copy)NSString *author;
/**
 *绝对ID
 */
@property (nonatomic, copy)NSString *cateId;
/**
 *绝对名称
 */
@property (nonatomic, copy)NSString *cateName;
/**
 *简介
 */
@property (nonatomic, copy)NSString *desc;
/**
 *下载地址
 */
@property (nonatomic, copy)NSString *downAct;
/**
 *下载次数
 */
@property (nonatomic, copy)NSString *downTimes;
/**
 *app图标
 */
@property (nonatomic, copy)NSString *icon;
/**
 *app标识符
 */
@property (nonatomic, copy)NSString *identifier;
/**
 *app  introReason
 */
@property (nonatomic, copy)NSString *introReason;
/**
 *lan
 */
@property (nonatomic, copy)NSString *lan;
/**
 *minFw
 */
@property (nonatomic, copy)NSString *minFw;
/**
 *名称
 */
@property (nonatomic, copy)NSString *name;
/**
 *价钱
 */
@property (nonatomic, copy)NSString *price;
/**
 *推荐应用
 */
@property (nonatomic, strong)NSArray *recommendSofts;
/**
 *兼容性
 */
@property (nonatomic, copy)NSString *requirement;
/**
 * resID
 */
@property (nonatomic, copy)NSString *resId;
/**
 * 版本
 */
@property (nonatomic, copy)NSString *sharer;
/**
 * 大小
 */
@property (nonatomic, copy)NSString *size;
/**
 * 照片集合
 */
@property (nonatomic, strong)NSArray *snapshots;
/**
 * 星级
 */
@property (nonatomic, copy)NSString *star;
/**
 * 更新时间
 */
@property (nonatomic, copy)NSString *updateTime;
/**
 * 版本号
 */
@property (nonatomic, copy)NSString *versionCode;
/**
 * 版本名称
 */
@property (nonatomic, copy)NSString *versionName;


@end
