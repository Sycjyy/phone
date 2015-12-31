//
//  SYCSearchSubView.h
//  91助手
//
//  Created by sycjyy on 15/12/14.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SYCSearchSubViewDelegate <NSObject>

@optional
- (void)searchBarJumpToCateView:(UIButton *)btn;
- (void)searchBarDeleteRecordArray;
@end
@interface SYCSearchSubView : UIScrollView

@property (nonatomic, weak)id<SYCSearchSubViewDelegate>searchDelegate;

+ (instancetype)subViewsOfHotSearchWithFrame:(CGRect)frame andArray:(NSArray *)array;

+ (instancetype)subViewsOfHistorySearchWithFrame:(CGRect)frame andArray:(NSArray *)array;

@end
