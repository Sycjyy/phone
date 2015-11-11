//
//  GBCStatusCellFrame.m
//  phoneAssistant
//
//  Created by Denny_cheng on 15/9/11.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import "GBCStatusCellFrame.h"

@implementation GBCStatusCellFrame

- (void)setStatusHome:(GBCStatusHome *)statusHome
{
    _statusHome=statusHome;
    
    NSUInteger padding = 5;
    NSUInteger margin = 10;
    
    //计算app图片的frame
    NSUInteger iconX = margin;
    NSUInteger iconY = padding;
    NSUInteger iconW = 60;
    NSUInteger iconH = iconW;
    _IconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    //计算name的frame
    NSUInteger nameX = CGRectGetMaxX(_IconFrame)+2*padding;
    NSUInteger nameY = iconY;
    NSUInteger nameW = 170;
    NSUInteger nameH = 20;
    _NameFrame = CGRectMake(nameX, nameY, nameW, nameH);
    
    //计算星级的frame
    NSUInteger starX = nameX;
    NSUInteger starY = CGRectGetMaxY(_NameFrame)+padding;
    NSUInteger starW = 80;
    NSUInteger starH = 12;
    _StarFrame = CGRectMake(starX, starY, starW, starH);
    
    //计算下载次数的frame
    NSUInteger downTimesX = nameX;
    NSUInteger downTimesY = CGRectGetMaxY(_StarFrame)+padding;
    NSUInteger downTimesW = 90;
    NSUInteger downTimesH = starH;
    _downTimesFrame = CGRectMake(downTimesX, downTimesY, downTimesW, downTimesH);
    
    //计算大小的frame
    NSUInteger sizeX = CGRectGetMaxX(_downTimesFrame)+20;
    NSUInteger sizeY = downTimesY;
    NSUInteger sizeW = 70;
    NSUInteger sizeH = downTimesH;
    _sizeFrame = CGRectMake(sizeX, sizeY, sizeW, sizeH);
    
    
    
    //计算按钮的frame
    NSUInteger buttonW = 50;
    NSUInteger buttonH = 30;
    NSUInteger buttonX = [UIScreen mainScreen].bounds.size.width-buttonW-margin;
    NSUInteger buttonY = (CGRectGetMaxY(_IconFrame)+iconY-buttonH)/2;
    
    //计算button或price的frame
    if (statusHome.price.length>4) {
        _priceFrame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }else{
        _buttonFrame=CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }
    //计算originalPrice大小的frame
    if (statusHome.originalPrice.length>4) {
        NSUInteger originalX=buttonX;
        NSUInteger originalW=buttonW;
        NSUInteger originalH=10;
        NSUInteger originalY=buttonY-originalH;
        _originalFrame=CGRectMake(originalX, originalY, originalW, originalH);
    }
    
    
    _cellHeight = CGRectGetMaxY(_IconFrame)+padding;
    
}

@end
