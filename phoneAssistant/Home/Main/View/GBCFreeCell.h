//
//  GBCFreeCell.h
//  phoneAssistant
//
//  Created by Denny_cheng on 15/9/22.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GBCFreeCellShowDetailDelegate <NSObject>

@optional
- (void)showDetailView:(NSString *)detailUrl;
@end

@interface GBCFreeCell : UITableViewCell
@property(nonatomic,strong) NSArray *arrXsmf;
@property(nonatomic,weak) id<GBCFreeCellShowDetailDelegate> delegate;

@end
