//
//  SYCRefreshView.m
//  91助手
//
//  Created by sycjyy on 15/12/20.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCRefreshView.h"

@implementation SYCRefreshView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        imageView.image = [UIImage imageNamed:@"icon_leading"];
        imageView.center = self.center;
        [self addSubview:imageView];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
