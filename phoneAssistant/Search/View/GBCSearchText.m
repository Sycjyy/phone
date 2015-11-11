//
//  GBCSearchText.m
//  phoneAssistant
//
//  Created by Denny_cheng on 15/9/2.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import "GBCSearchText.h"

@implementation GBCSearchText



- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect rect=self.leftView.frame;
    self.leftView.frame=CGRectMake(rect.origin.x+5, rect.origin.y, rect.size.width, rect.size.height);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
