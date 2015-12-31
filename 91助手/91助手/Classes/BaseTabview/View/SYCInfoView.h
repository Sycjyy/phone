//
//  SYCInfoView.h
//  91助手
//
//  Created by sycjyy on 15/12/7.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SYCAppMoreBaseItem;
@interface SYCInfoView : UIView

@property (nonatomic, weak)SYCAppMoreBaseItem *baseItem;

- (CGFloat)heightForInformationView;
@end
