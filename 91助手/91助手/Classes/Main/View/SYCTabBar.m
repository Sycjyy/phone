//
//  SYCTabBar.m
//  91助手
//
//  Created by sycjyy on 15/11/26.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCTabBar.h"
#import "SYCTabBarButton.h"

@interface SYCTabBar()

@property (nonatomic, weak)UIButton *selectedButton;
@property (nonatomic, strong)NSMutableArray *buttons;

@end

@implementation SYCTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tab_background"]];
    }
    return self;
}

- (NSMutableArray *)buttons{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (void)setItems:(NSArray *)items{
    _items = items;
    
    for (UITabBarItem *item in items) {
        SYCTabBarButton *btn = [SYCTabBarButton buttonWithType:UIButtonTypeCustom];
        btn.item = item;
        btn.tag = self.buttons.count;
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
        
        if (btn.tag == 0) {
            [self buttonClick:btn];
        }
        //添加到view
        [self addSubview:btn];
        [self.buttons addObject:btn];
    }
}
#pragma mark -点击tabBarButton方法
- (void)buttonClick:(UIButton *)btn{
    _selectedButton.selected = NO;
    btn.selected = YES;
    _selectedButton = btn;
    //切换控制器
    if ([_delegate respondsToSelector:@selector(tabBar:didClickButton:)]) {
        [_delegate tabBar:self didClickButton:btn.tag];
    }
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat screenW = self.bounds.size.width;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = screenW / self.buttons.count;
    CGFloat btnH = self.bounds.size.height;
    
    int i = 0;
    for (UIButton *btn in self.subviews) {
        btnX = btnW * i;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        i++;
    }
}

@end
