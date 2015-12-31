//
//  SYCHttpTool.m
//  91助手
//
//  Created by sycjyy on 15/11/29.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCHttpTool.h"

#import "AFNetworking.h"

@implementation SYCHttpTool

+(void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    [manger GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSLog(@"operation: %@\n\n", operation.responseString);
        
        if (success) {
            success(responseObject);
        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            failure(error);
        }
    }];
}

+(void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            failure(error);
        }
    }];
}
@end
