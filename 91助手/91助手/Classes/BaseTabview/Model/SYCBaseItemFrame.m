//
//  SYCBaseItemFrame.m
//  91助手
//
//  Created by sycjyy on 15/12/6.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//



#import "SYCBaseItemFrame.h"
#import "SYCAppMoreBaseItem.h"


#define ScreenW [UIScreen mainScreen].bounds.size.width

@implementation SYCBaseItemFrame

-(void)setBaseItem:(SYCAppMoreBaseItem *)baseItem{
    _baseItem = baseItem;
    //计算display frame
    _imageDisplayFrame = CGRectMake(0, 20, ScreenW, 300);
    //计算openBar frame
    _openBarFrame = CGRectMake(0, CGRectGetMaxY(_imageDisplayFrame), ScreenW, 100);
    //计算introduce frame
//    _introduceFrame
    
}
@end
