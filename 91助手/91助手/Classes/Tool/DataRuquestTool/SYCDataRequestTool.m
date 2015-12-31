//
//  SYCDataRequestTool.m
//  91助手
//
//  Created by sycjyy on 15/12/1.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCDataRequestTool.h"

#import "SYCHttpTool.h"

#import "SYCHomeResult.h"
#import "SYCHomePart.h"
#import "SYCAppBaseResult.h"
#import "SYCAppBaseItem.h"
#import "SYCHeaderValue.h"
#import "SYCAppMoreBaseItem.h"
#import "SYCChatItem.h"
#import "SYCCatebaseItem.h"

@implementation SYCDataRequestTool
//首页请求
+ (void)dataRequestOfHomeParam:(NSString *)paramStr success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    
    [SYCHttpTool GET:@"http://applebbx.sj.91.com/api/?cuid=3428d2caf0eb10eeb75f39d9d3ed91cdaaf5a419&act=1&imei=612976FF-5EC4-4E9C-9C8F-A5689CB586C9&spid=2&osv=8.4.1&dm=iPhone7,2&sv=3.1.3&nt=10&mt=1&pid=2" parameters:nil success:^(id responseObject) {
//        NSLog(@"%@",responseObject);
        SYCHomeResult *result = [SYCHomeResult objectWithKeyValues:responseObject[@"Result"][0]];
        
//        for (SYCHomePart *part in result.parts) {
//            NSLog(@"%@",part.name);
//        }
        
        if (success) {
            success(result.parts);
        }
        
    } failure:^(NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }
    }];
}
//首页每组的请求
+(void)dataRequestOfHomeSubGroupPart:(SYCHomePart *)part withUrlStr:(NSString *)urlStr success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure{
    
    if ([part.name isEqualToString:@"精品推荐"]) {
        part.act = @"http://applebbx.sj.91.com/soft/phone/list.aspx?cuid=3428d2caf0eb10eeb75f39d9d3ed91cdaaf5a419&act=244&imei=612976FF-5EC4-4E9C-9C8F-A5689CB586C9&spid=2&osv=8.4.1&dm=iPhone7,2&sv=3.1.3&top=20&mt=1&nt=10&pid=2";
    }else if ([part.name isEqualToString:@"黑马闯入"]){
        part.act = @"http://applebbx.sj.91.com/soft/phone/list.aspx?cuid=3428d2caf0eb10eeb75f39d9d3ed91cdaaf5a419&act=245&imei=612976FF-5EC4-4E9C-9C8F-A5689CB586C9&spid=2&osv=8.4.1&dm=iPhone7,2&sv=3.1.3&top=10&mt=1&nt=10&pid=2";
    }else if ([part.name isEqualToString:@"编辑推荐"]){
        part.act = @"http://applebbx.sj.91.com/soft/phone/list.aspx?skip=10&mt=1&spid=2&osv=8.4.1&cuid=3428d2caf0eb10eeb75f39d9d3ed91cdaaf5a419&imei=612976FF-5EC4-4E9C-9C8F-A5689CB586C9&dm=iPhone7,2&sv=3.1.3&act=244&nt=10&pid=2&top=10";
    }else if([part.name isEqualToString:@"限时免费"]){
        part.act = @"http://applebbx.sj.91.com/api/?act=236&cuid=3428d2caf0eb10eeb75f39d9d3ed91cdaaf5a419&spid=2&imei=612976FF-5EC4-4E9C-9C8F-A5689CB586C9&osv=8.4.1&dm=iPhone7,2&sv=3.1.3&top=15&mt=1&nt=10&pid=2";
    }else if([part.name isEqualToString:@"装机必备"]){
        part.act = @"http://applebbx.sj.91.com/api/?act=236&cuid=3428d2caf0eb10eeb75f39d9d3ed91cdaaf5a419&spid=2&imei=612976FF-5EC4-4E9C-9C8F-A5689CB586C9&osv=8.4.1&dm=iPhone7,2&sv=3.1.3&top=15&mt=1&nt=10&pid=2";
    }else if([part.name isEqualToString:@"黑马闯入"]){
        part.act = @"http://applebbx.sj.91.com/soft/phone/list.aspx?cuid=3428d2caf0eb10eeb75f39d9d3ed91cdaaf5a419&act=245&imei=612976FF-5EC4-4E9C-9C8F-A5689CB586C9&spid=2&osv=8.4.1&dm=iPhone7,2&sv=3.1.3&top=10&mt=1&nt=10&pid=2";
    }else if ([part.name isEqualToString:@"应用专题"]){
        part.act = @"http://applebbx.sj.91.com/soft/phone/tag.aspx?cuid=3428d2caf0eb10eeb75f39d9d3ed91cdaaf5a419&act=212&imei=612976FF-5EC4-4E9C-9C8F-A5689CB586C9&spid=2&osv=8.4.1&dm=iPhone7,2&sv=3.1.3&nt=10&mt=1&pid=2";
    }
    
    [SYCHttpTool GET:part.act parameters:nil success:^(id responseObject) {
            
        NSMutableDictionary *partDict = [NSMutableDictionary dictionary];
        if ([responseObject[@"Result"] isKindOfClass:[NSDictionary class]]) {
//                NSLog(@"%@",responseObject[@"Result"][@"items"][0]);
//                NSLog(@"%@",responseObject[@"Result"][@"items"][0]);
            SYCAppBaseResult *result = [SYCAppBaseResult objectWithKeyValues:responseObject[@"Result"]];
            
            [partDict setObject:result.items forKey:part.name];
        }else{
            NSArray *items = [SYCAppBaseItem objectArrayWithKeyValuesArray:responseObject[@"Result"]];
//                SYCAppBaseItem *item = items[0];
//                NSLog(@"%@ -- %@ ",item.name,item.url);
            [partDict setObject:items forKey:part.name];
        }
        
        if (success) {
            success(partDict);
        }

    } failure:^(NSError *error) {
        if (error) {
            failure(error);
        }
    }];
}
//首页每组更多的请求
+ (void)dataRequestWithUrl:(NSString *)urlStr success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
   
    [SYCHttpTool GET:urlStr parameters:nil success:^(id responseObject) {
        
        
        NSArray *items = [NSArray array];
        if ([responseObject[@"Result"] isKindOfClass:[NSDictionary class]]) {
            SYCAppBaseResult *result = [SYCAppBaseResult objectWithKeyValues:responseObject[@"Result"]];
            items = result.items;
        }else{
//            NSLog(@"%@",responseObject[@"Result"][0]);
            items = [SYCAppBaseItem objectArrayWithKeyValuesArray:responseObject[@"Result"]];
            
        }
      
        if (success) {
            success(items);
        }
        
    } failure:^(NSError *error) {
        if (error) {
            failure(error);
        }
    }];
}
//首页头的请求
+ (void)dataRequestWithSuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    
    [SYCHttpTool GET:@"http://applebbx.sj.91.com/softs.ashx?adlt=1&spid=2&osv=8.2&places=1&imei=DC3D9A43-F22F-47D2-9CB1-F51AACEC1B47&dm=iPhone4,1&sv=3.1.3&act=222&pid=2&cuid=65f2d2d79dc229b68a466e6ca57dae2379b5af3a&nt=10&mt=1" parameters:nil success:^(id responseObject) {
        NSArray *value = [SYCHeaderValue objectArrayWithKeyValuesArray: responseObject[@"Result"][0][@"Value"]];
//        NSLog(@"%@",responseObject[@"Result"][0][@"Value"]);
        if (success) {
            success(value);
        }
        
    } failure:^(NSError *error) {
        if (error) {
            failure(error);
        }
    }];
}
//每个应用的最基础请求
+ (void)dataRequestWithDetailAppBaseUrl:(NSString *)detailUrl success:(void (^)(SYCAppMoreBaseItem *))success failure:(void (^)(NSError *))failure{
    [SYCHttpTool GET:detailUrl parameters:nil success:^(id responseObject) {
//        NSLog(@"%@",responseObject[@"Result"]);
        SYCAppMoreBaseItem *baseItem = [SYCAppMoreBaseItem objectWithKeyValues:responseObject[@"Result"]];
        
        if (success) {
            success(baseItem);
        }
    } failure:^(NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }
    }];

}
//聊吧的请求（可重用 给个类型 判断什么请求 返回什么模型）
+ (void)dataRequestWithChatUrl:(NSString *)urlStr success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    
    [SYCHttpTool GET:urlStr parameters:nil success:^(id responseObject) {
        NSArray *items = [SYCChatItem objectArrayWithKeyValuesArray:responseObject[@"Result"]];
        if (success) {
            success(items);
        }
    } failure:^(NSError *error) {
        if (error) {
            failure(error);
        }
    }];
}
//返回Result 是数组类型的请求
+ (void)dataRequestWithUrlStr:(NSString *)urlStr param:(NSString *)name success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    
    [SYCHttpTool GET:urlStr parameters:nil success:^(id responseObject) {
        
        NSArray *items = [NSArray array];
        if ([name isEqualToString:@"cate"]) {
            items = [SYCCatebaseItem objectArrayWithKeyValuesArray:responseObject[@"Result"]];
        }
        
        if (success) {
            success(items);
        }
    } failure:^(NSError *error) {
        if (error) {
            failure(error);
        }
    }];

    
}
//试验
+ (void)dataRequestTestWithUrl:(NSString *)urlStr success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    [SYCHttpTool GET:urlStr parameters:nil success:^(id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }
    }];
}
@end
