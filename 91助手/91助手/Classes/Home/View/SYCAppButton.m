//
//  SYCAppButton.m
//  91助手
//
//  Created by sycjyy on 15/12/1.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCAppButton.h"
#import "SYCAppBaseItem.h"
#import "UIImageView+WebCache.h"

@interface SYCAppButton()

@property (nonatomic, weak)UIImageView *iconView;

@property (nonatomic, weak)UILabel *nameView;

@end

@implementation SYCAppButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapUpInSize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(linkToBaseView)];
        [iconView addGestureRecognizer:tapUpInSize];
        [self addSubview:iconView];
        _iconView = iconView;
        
        UILabel *nameView = [[UILabel alloc] init];
        nameView.textAlignment = NSTextAlignmentCenter;
        nameView.font = [UIFont systemFontOfSize:12];
//        nameView.
        [self addSubview:nameView];
        _nameView = nameView;
    }
    return self;
}

- (void)linkToBaseView{
    NSLog(@"%s",__func__);
    SYCAppBaseItem *item = self.item;
    NSLog(@"%@",item.name);
    if ([self.delegate respondsToSelector:@selector(appButtonLinkToBaseView:)]) {
        [self.delegate appButtonLinkToBaseView:item];
    }
}


-(void)setItem:(SYCAppBaseItem *)item{
    _item = item;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.icon] placeholderImage:[UIImage imageNamed:@"icon_default"]];
    
    _nameView.text = item.name;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = 57;
    CGFloat imageH = imageW;
    self.iconView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    //title
    CGFloat titleX = 0;
    CGFloat titleY = imageH;
    CGFloat titleW = self.bounds.size.width;
    CGFloat titleH = self.bounds.size.height -titleY;
    self.nameView.frame = CGRectMake(titleX, titleY, titleW, titleH);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



@end
