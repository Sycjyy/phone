//
//  SYCHttpTool.h
//  91助手
//
//  Created by sycjyy on 15/11/29.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYCHttpTool : NSObject

/**
 *  发送GET请求
 *  parameters :请求参数
 *
 */
+(void)GET:(NSString *)URLString parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

/**
 *  发送POST请求
 *  parameters :请求参数
 *
 */
+ (void) POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;



@end
