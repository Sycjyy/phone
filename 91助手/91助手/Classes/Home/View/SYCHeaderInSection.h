//
//  SYCHeaderInSection.h
//  91助手
//
//  Created by sycjyy on 15/12/2.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SYCHomePart;

@protocol  SYCHeaderInSectionDelegate<NSObject>

@optional
- (void)headerLoadMoreData:(SYCHomePart *)part andUrl:(NSString *)moreUrl andSection:(NSInteger)section;

@end
@interface SYCHeaderInSection : UIView

@property (nonatomic, assign)NSInteger section;

@property (nonatomic, weak)SYCHomePart *part;

@property (nonatomic, weak)id<SYCHeaderInSectionDelegate>delegate;
@end
