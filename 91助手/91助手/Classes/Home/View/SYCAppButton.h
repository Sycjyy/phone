//
//  SYCAppButton.h
//  91助手
//
//  Created by sycjyy on 15/12/1.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SYCAppBaseItem;

@protocol SYCAppButtonDelegate <NSObject>

@optional
- (void)appButtonLinkToBaseView:(SYCAppBaseItem *)item;

@end
@interface SYCAppButton : UIView


@property (nonatomic, strong)SYCAppBaseItem *item;

@property (nonatomic, assign)id<SYCAppButtonDelegate>delegate;


@end
