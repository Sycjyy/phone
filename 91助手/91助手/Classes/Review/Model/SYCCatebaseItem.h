//
//  SYCCatebaseItem.h
//  91助手
//
//  Created by sycjyy on 15/12/11.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MJExtension.h"
@interface SYCCatebaseItem : NSObject<MJKeyValue>

@property (nonatomic, copy)NSString *icon;

@property (nonatomic, copy)NSString *name;

@property (nonatomic, copy)NSString *summary;

@property (nonatomic, strong)NSArray *listTags;
@end
