//
//  SYCAppSpecialViewCell.h
//  91助手
//
//  Created by sycjyy on 15/12/1.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SYCAppBaseItem;
@protocol SYCAppSpecialViewCellDelegate <NSObject>

@optional

- (void)appSpecialWithItem:(SYCAppBaseItem *)item;

@end

@interface SYCAppSpecialViewCell : UITableViewCell

@property (nonatomic, strong)NSArray *items;

@property (nonatomic, weak)id<SYCAppSpecialViewCellDelegate>delegate;

+ (instancetype)cellWithTableview:(UITableView *)tableview;
@end
