//
//  GBCStatuscell.h
//  phoneAssistant
//
//  Created by Denny_cheng on 15/9/21.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GBCStatusCellFrame;

@interface GBCStatuscell : UITableViewCell
//类构造方法
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong) GBCStatusCellFrame *statusCellFrame;

@end
