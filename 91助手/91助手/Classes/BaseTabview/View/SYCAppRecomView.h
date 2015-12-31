//
//  SYCAppRecomView.h
//  91助手
//
//  Created by sycjyy on 15/12/5.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SYCAppMoreBaseItem,SYCAppBaseItem;

@protocol SYCAppRecomViewDelegate <NSObject>

@optional
- (void)recomViewJustToBaseViewWithItem:(SYCAppBaseItem *)item;

@end
@interface SYCAppRecomView : UIView

@property (nonatomic, strong)SYCAppMoreBaseItem *baseItem;

@property (nonatomic, weak)id<SYCAppRecomViewDelegate>delegate;

@end
