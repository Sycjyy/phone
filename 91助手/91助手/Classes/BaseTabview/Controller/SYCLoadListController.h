//
//  SYCLoadListController.h
//  91助手
//
//  Created by sycjyy on 15/11/30.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SYCHomePart,SYCAppBaseItem;
@interface SYCLoadListController : UITableViewController

@property (nonatomic, strong)SYCAppBaseItem * passItem;

@property (nonatomic, copy)NSString *moreUrl;

@property (nonatomic, strong)SYCHomePart *part;
@end
