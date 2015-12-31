//
//  SYCAppIntroduceView.m
//  91助手
//
//  Created by sycjyy on 15/12/4.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//


#define viewW self.bounds.size.width
#define viewH self.bounds.size.height
#define ScreenW [UIScreen mainScreen].bounds.size.width

#import "SYCAppIntroduceView.h"
#import "SYCAppMoreBaseItem.h"

@interface SYCAppIntroduceView()

@property (nonatomic, weak)UILabel *titleView;

@property (nonatomic, weak)UILabel *contentView;



@property (nonatomic, weak)UIView *lineView;
@end
@implementation SYCAppIntroduceView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self setUpAllChildView];
    }
    return self;
}

- (void)setUpAllChildView{
    UILabel *titleView = [[UILabel alloc] init];
    titleView.text = @"应用简介";
    titleView.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:18];
    _titleView = titleView;
    [self addSubview:titleView];
    
    UILabel *contentView = [[UILabel alloc] init];
    contentView.numberOfLines = 0;
    _contentView = contentView;
    [self addSubview:contentView];
    
    UIButton *transView = [UIButton buttonWithType:UIButtonTypeCustom];
    transView.backgroundColor = [UIColor blueColor];
    [transView setTitle:@"展开" forState:UIControlStateNormal];
    [transView setTitle:@"收缩" forState:UIControlStateSelected];
    [transView addTarget:self action:@selector(transformToFrame) forControlEvents:UIControlEventTouchDown];
    _transView = transView;
    [self addSubview:transView];
    //lineView
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor grayColor];
    _lineView = lineView;
    [self addSubview:lineView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(performClickBtn)];
    [self addGestureRecognizer:tapGesture];
}

- (void)performClickBtn{
    [self transformToFrame];
}

- (void)transformToFrame{
    _transView.selected = !_transView.selected;
    
    [self layoutSubviews];
    
//    [self sizeToFit];
    
    if ([_delegate respondsToSelector:@selector(reloadDataFrame)]) {
        [_delegate reloadDataFrame];
    }
}

- (CGFloat)heightForIntroduceView{
    return CGRectGetMaxY(_lineView.frame);
}

- (void)setBaseItem:(SYCAppMoreBaseItem *)baseItem{
    _baseItem = baseItem;
    
    _contentView.text = baseItem.desc;
    [_contentView sizeToFit];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat margin = 15;
//    NSLog(@"three");
    _titleView.frame = CGRectMake(20, 15, 80, 24);
    
    [_contentView sizeToFit];
    CGSize size = _contentView.bounds.size;
    CGFloat contentX = 20;
    CGFloat contentY = CGRectGetMaxY(_titleView.frame) + 5;
    CGFloat contentW = viewW - 40;
    CGFloat contentH = 0;
    if (_transView.selected) {
        contentH = size.height;
    }else{
        contentH = 50;
    }
    _contentView.frame = CGRectMake(contentX, contentY, contentW, contentH);
    
        CGFloat transW = 50;
        CGFloat transH = 20;
        CGFloat transX = viewW - transW - margin;
        CGFloat transY = CGRectGetMaxY(_contentView.frame) + 3;
        _transView.frame = CGRectMake(transX, transY, transW, transH);
                
        CGFloat lineX = 0;
        CGFloat lineY = CGRectGetMaxY(_transView.frame) + 5;
        CGFloat lineW = viewW;
        CGFloat lineH = 1;
        _lineView.frame = CGRectMake(lineX, lineY, lineW, lineH);
//    }
    

}
@end
