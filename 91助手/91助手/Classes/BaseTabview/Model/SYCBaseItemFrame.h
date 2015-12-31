//
//  SYCBaseItemFrame.h
//  91助手
//
//  Created by sycjyy on 15/12/6.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <CoreGraphics/CoreGraphics.h>

@class SYCAppMoreBaseItem;
@interface SYCBaseItemFrame : NSObject

@property (nonatomic, weak)SYCAppMoreBaseItem *baseItem;

@property (nonatomic, assign)CGRect imageDisplayFrame;

@property (nonatomic, assign)CGRect openBarFrame;

@property (nonatomic, assign)CGRect introduceFrame;

@property (nonatomic, assign)CGRect appRecomFrame;
@end
