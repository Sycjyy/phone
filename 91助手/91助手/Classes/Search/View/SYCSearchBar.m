//
//  SYCSearchBar.m
//  91助手
//
//  Created by sycjyy on 15/12/14.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCSearchBar.h"

#import "UIImage+Image.h"
#import "UIView+Frame.h"

@implementation SYCSearchBar

+ (instancetype)searchBarWithFrame:(CGRect)frame{
    SYCSearchBar *searchBar = [[self alloc] initWithFrame:frame];
    searchBar.font = [UIFont systemFontOfSize:17];
    searchBar.background = [UIImage imageWithStretchableName:@"search_nor"];
    searchBar.placeholder = @"搜索";
    searchBar.borderStyle = UITextBorderStyleRoundedRect;
    searchBar.enablesReturnKeyAutomatically = YES;
    searchBar.returnKeyType = UIReturnKeySearch;

    UIImageView *searchIcon = [[UIImageView alloc] initWithFrame:CGRectMake(150, 5, 20, 20)];
    searchIcon.width += 10;
    searchIcon.contentMode = UIViewContentModeCenter;
    searchIcon.image = [UIImage imageNamed:@"search_icon"];
    searchBar.leftView = searchIcon;
    searchBar.leftViewMode = UITextFieldViewModeAlways;
    searchBar.contentMode = UIViewContentModeCenter;
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"search_close_click_nor"] forState:UIControlStateNormal];
    closeBtn.frame = CGRectMake(0, 5, 25, 25);
    [closeBtn addTarget:self action:@selector(justToSearchBar:) forControlEvents:UIControlEventTouchUpInside];
    searchBar.rightView = closeBtn;
    searchBar.rightViewMode = UITextFieldViewModeAlways;//选择方式
    searchBar.rightView.hidden = YES;
    
    NSDictionary *dict = @{@"btn":closeBtn};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"testtwo" object:closeBtn userInfo:dict];
    
    return searchBar;
}

+ (void)justToSearchBar:(UIButton *)btn{
    //看看能否用通知或者kvo实现
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"testone" object:nil];
    NSLog(@"%s",__func__);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
