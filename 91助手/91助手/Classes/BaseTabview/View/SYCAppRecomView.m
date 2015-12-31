//
//  SYCAppRecomView.m
//  91助手
//
//  Created by sycjyy on 15/12/5.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#define viewW self.bounds.size.width
#define viewH self.bounds.size.height
#define ScreenW [UIScreen mainScreen].bounds.size.width


#import "SYCAppRecomView.h"

#import "SYCAppMoreBaseItem.h"
#import "SYCAppBaseItem.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

@interface SYCAppRecomView()

@property (nonatomic, weak)UILabel *titleView;

@property (nonatomic, weak)UIScrollView *scrollView;

@property (nonatomic, weak)UIView *lineView;

@end
@implementation SYCAppRecomView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpAllChildView];
    }
    return self;
}

- (void)setUpAllChildView{
    UILabel *titleView = [[UILabel alloc] init];
    titleView.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:18];
    titleView.text = @"下载此应用的人也下载了";
    _titleView = titleView;
    [self addSubview:titleView];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView = scrollView;
    [self addSubview:scrollView];
    //lineView
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor grayColor];
    _lineView = lineView;
    [self addSubview:lineView];
}

- (void)setBaseItem:(SYCAppMoreBaseItem *)baseItem{
    _baseItem = baseItem;
    //设置scrollcontent size
    NSInteger num = baseItem.recommendSofts.count;
    CGFloat margin = 5;
    CGFloat space = 25;
    CGFloat iconX = 0;
    CGFloat iconY = 0;
    CGFloat iconW = 60;
    CGFloat iconH = iconW;
    _scrollView.contentSize = (CGSize){2*margin + num * (iconW + space),iconH};
    //往scroll 里添加小控件
    for (int i = 0; i < num; i++) {
        SYCAppBaseItem *item = baseItem.recommendSofts[i];
        iconX = margin + i*(iconW + space);
        
        UIButton *iconView = [UIButton buttonWithType:UIButtonTypeCustom];
        iconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
//        NSLog(@"%s,%@",__func__,[NSThread currentThread]);
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [iconView sd_setImageWithURL:[NSURL URLWithString:item.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_default"]];
//            NSLog(@"%s,%@",__func__,[NSThread currentThread]);
        });
        
        iconView.highlighted = NO;
        iconView.tag = i;
        [iconView addTarget:self action:@selector(clickIconView:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:iconView];
    }
}

- (void)clickIconView:(UIButton *)btn{
    SYCAppBaseItem *item = _baseItem.recommendSofts[btn.tag];
//    NSLog(@"%@",item);
    if ([_delegate respondsToSelector:@selector(recomViewJustToBaseViewWithItem:)]) {
        [_delegate recomViewJustToBaseViewWithItem:item];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _titleView.frame = CGRectMake(20, 15, 250, 20);
    CGFloat margin = 15;
    CGFloat scroW = viewW - 2*margin;
    CGFloat scroX = margin;
    CGFloat scroY = CGRectGetMaxY(_titleView.frame) + margin;
    CGFloat scroH = 60;
    _scrollView.frame = CGRectMake(scroX, scroY, scroW, scroH);
    CGFloat lineX = 0;
    CGFloat lineY = viewH - 1;
    CGFloat lineW = viewW;
    CGFloat lineH = 1;
    _lineView.frame = CGRectMake(lineX, lineY, lineW, lineH);

    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
