//
//  SYCAppIntroduceView.h
//  91助手
//
//  Created by sycjyy on 15/12/4.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SYCAppMoreBaseItem;

@protocol SYCAppIntroduceViewDelegate <NSObject>

@optional
- (void)transformFrame:(CGRect)rect;
- (void)reloadDataFrame;

@end
@interface SYCAppIntroduceView : UIView

@property (nonatomic, weak)UIButton *transView;

@property (nonatomic, weak)SYCAppMoreBaseItem *baseItem;

@property (nonatomic, weak)id<SYCAppIntroduceViewDelegate>delegate;

- (CGFloat)heightForIntroduceView;
@end
