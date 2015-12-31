//
//  SYCHeaderInTableView.m
//  91助手
//
//  Created by sycjyy on 15/12/2.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCHeaderInTableView.h"

#import "SYCHeaderValue.h"
#import "UIImageView+WebCache.h"

#define selfSize self.bounds.size

@interface SYCHeaderInTableView()<UITableViewDelegate>

@property (nonatomic, weak)UIPageControl *pageContrl;

@property (nonatomic, weak)UIScrollView *scrollView;
@end

@implementation SYCHeaderInTableView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
        scrollView.bounces = NO;
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.delegate = self;
        _scrollView = scrollView;
        [self addSubview:scrollView];
        UIPageControl *pageContrl = [[UIPageControl alloc] init];
        _pageContrl = pageContrl;
        [self addSubview:pageContrl];
        
    }
    return self;
}

- (void)setValues:(NSArray *)values{
    _values = values;
    
    [self setUpAllChildAndAttribute];
    
    [self setUpPageContrl];
    
    [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
}

- (void)setUpAllChildAndAttribute{
    _scrollView.contentSize = (CGSize){_values.count * self.bounds.size.width,self.bounds.size.height};
    
    CGFloat iconX = 0;
    CGFloat iconY = 0;
    CGFloat iconW = self.bounds.size.width;
    CGFloat iconH = self.bounds.size.height;
    for (int i = 0; i < _values.count; i++) {
        iconX = i * iconW;
        CGRect iconRect = CGRectMake(iconX, iconY, iconW, iconH);
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:iconRect];
        iconView.tag = i;
        iconView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapIconView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapIcon)];
        [iconView addGestureRecognizer:tapIconView];
        SYCHeaderValue *value = _values[i];
        [iconView sd_setImageWithURL:[NSURL URLWithString:value.LogoUrl]];
        [_scrollView addSubview:iconView];
    }
}

- (void)setUpPageContrl{
    _pageContrl.currentPageIndicatorTintColor = [UIColor orangeColor];
    _pageContrl.numberOfPages = _values.count;
    _pageContrl.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height - 5);
}

- (void)autoScroll{
//    NSLog(@"%s",__func__);
    NSInteger page = _pageContrl.currentPage;
    CGFloat x = _scrollView.contentOffset.x;
    if (page == _values.count -1) {
        page = 0;
        x = 0;
    }else{
        page++;
        x = x + selfSize.width;
    }
    [UIView animateWithDuration:1 animations:^{
        _pageContrl.currentPage = page;
        _scrollView.contentOffset = (CGPoint){x,0};
    }];
//    _pageContrl.currentPage = page;
//    _scrollView.contentOffset = (CGPoint){x,0};
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = _scrollView.contentOffset.x / selfSize.width + 0.5;
    
    _pageContrl.currentPage = page;
}

- (void)tapIcon{
    SYCHeaderValue *value = self.values[_pageContrl.currentPage];
    
    if ([_delegate respondsToSelector:@selector(headerLoadDataWith:)]) {
        [_delegate headerLoadDataWith:value];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
