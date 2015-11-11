//
//  GBCYyztCell.h
//  phoneAssistant
//
//  Created by Denny_cheng on 15/9/22.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GBCYyztCellDelegate <NSObject>

@optional
- (void)sendArray:(NSArray *)array tag:(NSUInteger)tag;

@end

@interface GBCYyztCell : UITableViewCell
@property(nonatomic,strong) NSArray *arrYyzt;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *url;
@property(nonatomic,assign) NSUInteger startNum;
@property(nonatomic,assign) NSUInteger endNum;

@property(nonatomic,weak) id<GBCYyztCellDelegate> delegate;

@end
