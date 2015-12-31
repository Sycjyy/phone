//
//  SYCDataRequestTool.h
//  91助手
//
//  Created by sycjyy on 15/12/1.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SYCHomePart,SYCAppMoreBaseItem;
@interface SYCDataRequestTool : NSObject
/**
 *首页布局请求
 */
+ (void)dataRequestOfHomeParam:(NSString *)paramStr success:(void(^)(NSArray *parts))success failure:(void(^)(NSError *error))failure;
/**
 *首页每一个组的请求
 */
+ (void)dataRequestOfHomeSubGroupPart:(SYCHomePart *)part withUrlStr:(NSString *)urlStr success:(void(^)(NSDictionary *group))success failure:(void(^)(NSError *error))failure;
/**
 *类似应用专题 请求
 */
+ (void)dataRequestWithUrl:(NSString *)urlStr success:(void(^)(NSArray *items))success failure:(void(^)(NSError *error))failure;

/**
 *首页头 请求
 */
+ (void)dataRequestWithSuccess:(void(^)(NSArray *values))success failure:(void(^)(NSError *error))failure;

/**
 *每个应用的请求 Result 模型
 */
+ (void)dataRequestWithDetailAppBaseUrl:(NSString *)detailUrl success:(void(^)(SYCAppMoreBaseItem *baseItem))success failure:(void(^)(NSError *error))failure;

/**
 *聊吧的请求 Result 数组
 */
+ (void)dataRequestWithChatUrl:(NSString *)urlStr success:(void(^)(NSArray *items))success failure:(void(^)(NSError *error))failure;

/**
 * 返回的Result为数组类型的统一请求
 */
+ (void)dataRequestWithUrlStr:(NSString *)urlStr param:(NSString *)name success:(void(^)(NSArray *items))success failure:(void(^)(NSError *error))failure;


/**
 *试验
 */
+ (void)dataRequestTestWithUrl:(NSString *)urlStr success:(void(^)(NSArray *values))success failure:(void(^)(NSError *error))failure;
@end
