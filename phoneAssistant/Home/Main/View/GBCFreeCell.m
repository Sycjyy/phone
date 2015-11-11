//
//  GBCFreeCell.m
//  phoneAssistant
//
//  Created by Denny_cheng on 15/9/22.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//
#define SCROLLW [UIScreen mainScreen].bounds.size.width
#define SCROLLH [UIScreen mainScreen].bounds.size.height


#import "GBCFreeCell.h"
#import "UIButton+WebCache.h"
#import "GBCStatusCellFrame.h"

@interface GBCFreeCell ()
@property(nonatomic,weak) UIScrollView *scrollView;

@end

@implementation GBCFreeCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIScrollView *scroll=[[UIScrollView alloc] init];
        scroll.frame=CGRectMake(0, 0, SCROLLW, SCROLLH);
        self.scrollView=scroll;
        [self.contentView addSubview:scroll];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger margin=10;
    NSUInteger width=60;
        
    self.scrollView.contentSize=CGSizeMake(margin+(width+margin)*self.arrXsmf.count, SCROLLH);
    for (NSUInteger i=0; i<self.arrXsmf.count; i++) {
        UIButton *btn=[[UIButton alloc] init];
        btn.tag=i;
        NSUInteger btnX=(margin+width)*i+margin;
        NSUInteger btnY=5;
        NSUInteger btnW=width;
        NSUInteger btnH=btnW;
        btn.frame=CGRectMake(btnX, btnY, btnW, btnH);
        GBCStatusHome *status=[[GBCStatusHome alloc] init];
        status=self.arrXsmf[i];
        NSURL *url=[NSURL URLWithString:status.icon];
        [btn sd_setBackgroundImageWithURL:url forState:(UIControlStateNormal) placeholderImage:[UIImage imageNamed:@"image_loading"]];
        [btn sd_setBackgroundImageWithURL:url forState:(UIControlStateHighlighted) placeholderImage:[UIImage imageNamed:@"image_loading"]];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.scrollView addSubview:btn];
        
        UILabel *textLal=[[UILabel alloc] init];
        textLal.frame=CGRectMake(btnX, CGRectGetMaxY(btn.frame)+5, btnW, 10);
        textLal.font=[UIFont systemFontOfSize:12];
        [textLal setTextAlignment:NSTextAlignmentCenter];
        textLal.text=status.name;
        [self.scrollView addSubview:textLal];
    }
    
}

- (void)btnClick:(UIButton *)btn
{
    GBCStatusHome *status=[[GBCStatusHome alloc] init];
    status=self.arrXsmf[btn.tag];
    if ([self.delegate respondsToSelector:@selector(showDetailView:)]) {
        [self.delegate showDetailView:status.detailUrl];
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
