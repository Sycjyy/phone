//
//  SYCAppSpecialSubViewCell.h
//  91助手
//
//  Created by sycjyy on 15/12/2.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SYCAppBaseItem;
@interface SYCAppSpecialSubViewCell : UITableViewCell

@property (nonatomic, weak)SYCAppBaseItem *item;

+ (instancetype)cellWithTableview:(UITableView *)tableview;
@end
