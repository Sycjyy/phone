//
//  SYCHomeResult.h
//  91助手
//
//  Created by sycjyy on 15/11/29.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MJExtension.h"
@interface SYCHomeResult : NSObject<MJKeyValue>

@property (nonatomic, strong)NSArray *parts;

@property (nonatomic, copy)NSString *showAd;

@property (nonatomic, copy)NSString *uiPlace;

@property (nonatomic, assign)BOOL isAudit;
@end
