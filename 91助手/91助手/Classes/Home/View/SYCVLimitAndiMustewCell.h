//
//  SYCVLimitAndiMustewCell.h
//  91助手
//
//  Created by sycjyy on 15/12/1.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SYCAppBaseItem;
@protocol SYCVLimitAndiMustewCellDelegate <NSObject>

@optional
- (void)appButtonLinkToBaseView:(SYCAppBaseItem *)item;

@end
@interface SYCVLimitAndiMustewCell : UITableViewCell

@property (nonatomic, weak)NSArray *items;

@property (nonatomic, weak)id<SYCVLimitAndiMustewCellDelegate> delegate;

+ (instancetype)cellWithTableview:(UITableView *)tableview;

@end
