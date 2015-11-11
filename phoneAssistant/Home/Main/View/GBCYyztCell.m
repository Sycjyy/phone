//
//  GBCYyztCell.m
//  phoneAssistant
//
//  Created by Denny_cheng on 15/9/22.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import "GBCYyztCell.h"
#import "GBCYyztModel.h"
#import "UIButton+WebCache.h"
#import "GBCHeaderTblController.h"
#import "GBCYyztModel.h"

@implementation GBCYyztCell

- (void)layoutSubviews
{
    [super layoutSubviews];

    NSUInteger margin=10;
    NSUInteger padding=5;
    CGSize size=[UIScreen mainScreen].bounds.size;
    for (NSUInteger i=self.startNum; i<self.endNum; i++) {
        UIButton *btn=[[UIButton alloc] init];
        GBCYyztModel *yyzt=self.arrYyzt[i];
        NSURL *url=[NSURL URLWithString:yyzt.icon];
        [btn sd_setBackgroundImageWithURL:url forState:(UIControlStateNormal) placeholderImage:[UIImage imageNamed:@"icon_leading"]];
        [btn sd_setBackgroundImageWithURL:url forState:(UIControlStateHighlighted) placeholderImage:[UIImage imageNamed:@"icon_leading"]];
        btn.tag=i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        NSUInteger count=2;//每行按钮(图片)的个数
        CGFloat btnW=(size.width-2*margin-padding*(count-1))/count;
        CGFloat btnH=100;
        CGFloat btnX=margin+(padding+btnW)*(i%count);
        CGFloat btnY=padding+(padding+btnH)*(NSUInteger)(i/count);
        btn.frame=CGRectMake(btnX, btnY, btnW, btnH);
        [self.contentView addSubview:btn];
    }
}

- (void)btnClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(sendArray:tag:)]) {
        [self.delegate sendArray:self.arrYyzt tag:btn.tag];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
