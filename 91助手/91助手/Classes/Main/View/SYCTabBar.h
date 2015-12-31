//
//  SYCTabBar.h
//  91助手
//
//  Created by sycjyy on 15/11/26.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SYCTabBar;
@protocol SYCTabBarDelegate <NSObject>

@optional
- (void)tabBar:(SYCTabBar *)tabBar didClickButton:(NSInteger)index;

@end

@interface SYCTabBar : UIView

@property (nonatomic, strong)NSArray *items;
@property (nonatomic, weak)id<SYCTabBarDelegate> delegate;
@end
