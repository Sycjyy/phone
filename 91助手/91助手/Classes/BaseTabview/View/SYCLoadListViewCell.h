//
//  SYCLoadListViewCell.h
//  91助手
//
//  Created by sycjyy on 15/11/30.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SYCAppBaseItem;
@interface SYCLoadListViewCell : UITableViewCell
/**
 *应用的基础数据模型
 */
@property (nonatomic, strong)SYCAppBaseItem *item;

+ (instancetype)cellWithTableview:(UITableView *)tableview;

@end
