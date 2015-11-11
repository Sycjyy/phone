//
//  GBCStatusCellFrame.h
//  phoneAssistant
//
//  Created by Denny_cheng on 15/9/11.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GBCStatusHome.h"

@interface GBCStatusCellFrame : NSObject
/**
 *  应用图片的frame
 */
@property(nonatomic,assign,readonly) CGRect IconFrame;
/**
 *  应用名称的frame
 */
@property(nonatomic,assign,readonly) CGRect NameFrame;
/**
 *  应用星级的frame
 */
@property(nonatomic,assign,readonly) CGRect StarFrame;
/**
 *  下载次数的frame
 */
@property(nonatomic,assign,readonly) CGRect downTimesFrame;
/**
 *   app的大小frame
 */
@property(nonatomic,assign,readonly) CGRect sizeFrame;
/**
 *  免费按钮的frame
 */
@property(nonatomic,assign) CGRect buttonFrame;
/**
 *  original的frame
 */
@property(nonatomic,assign) CGRect originalFrame;
/**
 *  price的frame
 */
@property(nonatomic,assign) CGRect priceFrame;



@property(nonatomic,strong) GBCStatusHome *statusHome;

@property(nonatomic,assign) CGFloat cellHeight;


@end
