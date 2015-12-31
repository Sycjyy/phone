//
//  SYCTabBarItem.m
//  91助手
//
//  Created by sycjyy on 15/11/26.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCTabBarButton.h"

@implementation SYCTabBarButton
//cancel highlight
- (void)setHighlighted:(BOOL)highlighted{}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tab_selection"]];
        //设置字体颜色
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        //image居中显示
        self.imageView.contentMode = UIViewContentModeCenter;
        //title水平居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        //title font
        self.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    
    return self;
}

- (void)setItem:(UITabBarItem *)item{
    _item = item;
    
    [item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    [self setTitle:_item.title forState:UIControlStateNormal];
    [self setImage:_item.image forState:UIControlStateNormal];
    [self setImage:_item.selectedImage forState:UIControlStateSelected];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //imageView
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = self.bounds.size.width;
    CGFloat imageH = self.bounds.size.height * 0.7;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    //title
    CGFloat titleX = 0;
    CGFloat titleY = imageH - 3;
    CGFloat titleW = self.bounds.size.width;
    CGFloat titleH = self.bounds.size.height -titleY;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
