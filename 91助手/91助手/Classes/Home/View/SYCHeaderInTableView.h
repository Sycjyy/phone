//
//  SYCHeaderInTableView.h
//  91助手
//
//  Created by sycjyy on 15/12/2.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SYCHeaderValue;
@protocol SYCHeaderInTableViewDelegate <NSObject>

@optional
- (void)headerLoadDataWith:(SYCHeaderValue *)value;

@end

@interface SYCHeaderInTableView : UIView

@property (nonatomic, weak)NSArray *values;

@property (nonatomic, weak)id<SYCHeaderInTableViewDelegate>delegate;

@end
