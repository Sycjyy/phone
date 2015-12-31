//
//  SYCAppBaseItem.h
//  91助手
//
//  Created by sycjyy on 15/11/29.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYCAppBaseItem : NSObject
/**
 *app类型
 */
@property (nonatomic, copy) NSString *appType;
/**
 *app作者
 */
@property (nonatomic, copy) NSString *author;
/**
 *app cateName
 */
@property (nonatomic, copy) NSString *cateName;
/**
 *app详细Url
 */
@property (nonatomic, copy) NSString *detailUrl;
/**
 *app下载地址
 */
@property (nonatomic, copy) NSString *downAct;
/**
 *app下载次数
 */
@property (nonatomic, copy) NSString *downTimes;
/**
 *app图标
 */
@property (nonatomic, copy) NSString *icon;
/**
 *app名字
 */
@property (nonatomic, copy) NSString *name;
/**
 *app原价
 */
@property (nonatomic, copy) NSString *originalPrice;
/**
 *app价格
 */
@property (nonatomic, copy) NSString *price;
/**
 *app  resId
 */
@property (nonatomic, copy) NSString *resId;
/**
 *app大小
 */
@property (nonatomic, copy) NSString *size;
/**
 *app星级
 */
@property (nonatomic, copy) NSString *star;
/**
 *app状态
 */
@property (nonatomic, copy) NSString *state;
/**
 *app描述
 */
@property (nonatomic, copy) NSString *summary;
/**
 *count
 */
@property (nonatomic, copy) NSString *count;
/**
 *专题的url
 */
@property (nonatomic, copy) NSString *url;
/**
 *app识别码
 */
@property (nonatomic, copy) NSString *identifier;
/**
 *app resName
 */
@property (nonatomic, copy) NSString *resName;


@end
