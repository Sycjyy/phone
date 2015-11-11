//
//  GBCXsmfModel.h
//  phoneAssistant
//
//  Created by Denny_cheng on 15/9/11.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBCHomeModel : NSObject
@property (nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *uiType;
@property (nonatomic,copy) NSString *act;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)homeWithDict:(NSDictionary *)dict;

@end
