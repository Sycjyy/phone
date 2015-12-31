//
//  SYCSearchSubView.m
//  91助手
//
//  Created by sycjyy on 15/12/14.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCSearchSubView.h"

@implementation SYCSearchSubView

//- (instancetype)initWithFrame:(CGRect)frame{
//    if (self = [super initWithFrame:frame]) {
//        
//    }
//    return self;
//}

+ (instancetype)subViewsOfHotSearchWithFrame:(CGRect)frame andArray:(NSArray *)array{
    SYCSearchSubView *hotView = [[self alloc] initWithFrame:frame];
    NSString *titleName = @"热门搜索";

    [hotView addAllSubViewWithArray:array andView:hotView andTitleName:titleName];
    return hotView;
}

+ (instancetype)subViewsOfHistorySearchWithFrame:(CGRect)frame andArray:(NSArray *)array{
    SYCSearchSubView *historyView = [[self alloc] initWithFrame:frame];
    NSString *titleName = @"搜索历史";
    [historyView addAllSubViewWithArray:array andView:historyView andTitleName:titleName];
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.frame = CGRectMake(historyView.frame.size.width - 25, 10, 25, 28);
    [deleteBtn setImage:[UIImage imageNamed:@"del_nor"] forState:UIControlStateNormal];
    [deleteBtn setImage:[UIImage imageNamed:@"del_click"] forState:UIControlStateHighlighted];
    [deleteBtn sizeToFit];
    [deleteBtn addTarget:self action:@selector(deleteRecordArr) forControlEvents:UIControlEventTouchUpInside];
    [historyView addSubview:deleteBtn];
    return historyView;
}

- (void)deleteRecordArr{
    if ([_searchDelegate respondsToSelector:@selector(searchBarDeleteRecordArray)]) {
        [_searchDelegate searchBarDeleteRecordArray];
    }
}

- (void)justToCateView:(UIButton *)btn{
//    NSLog(@"%@",btn.titleLabel.text);
    if ([_searchDelegate respondsToSelector:@selector(searchBarJumpToCateView:)]) {
        [_searchDelegate searchBarJumpToCateView:btn];
    }
}

- (void)addAllSubViewWithArray:(NSArray *)btnArr andView:(UIView *)addView andTitleName:(NSString *)titleName{
//    NSLog(@"%@",btnArr);
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 200, 30)];
    titleView.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
    titleView.text = titleName;
    [addView addSubview:titleView];
    
    CGFloat topW = addView.frame.size.width;
    CGFloat margin = 0;
    CGFloat spance = 10;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = 10;
    CGFloat btnH = 35;
    CGFloat sumW = margin;
    CGFloat row = 0;
    CGFloat num = 0;
    NSMutableArray *tmpArr = [NSMutableArray array];
    for (int i = 0; i < btnArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor grayColor];
        [btn setTitle:btnArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:18];
        [btn sizeToFit];
        btn.highlighted = NO;
        [btn addTarget:self action:@selector(justToCateView:) forControlEvents:UIControlEventTouchUpInside];
        btnW = btn.frame.size.width + 16;
        btnX = sumW;
        sumW = sumW + btnW + spance;
        
        if (sumW > topW ) {
            //            NSLog(@"%f,top-- %f",sumW,topW);
            CGFloat sumSW = margin;
            CGFloat increase = (topW - sumW + btnW + 2*spance)/(num*2);
            //            NSLog(@"%f",increase);
            for (int j = 0 ; j < tmpArr.count; j++) {
                UIButton *btnS = tmpArr[j];
                //                NSLog(@"%@",btnS.titleLabel.text);
                CGFloat btnSw = btnS.frame.size.width + 2*increase;
                CGFloat btnSx = sumSW ;
                sumSW = sumSW + btnSw + spance;
                
                if (j == 0) {
                    btnSx = margin;
                }
                CGFloat btnSy = CGRectGetMaxY(titleView.frame) + spance + row * (btnH + spance);
                btnS.frame = CGRectMake(btnSx, btnSy, btnSw, btnH);
            }
            sumW = margin;
            num = 0;
            row++;
            btnX = sumW;
            sumW = sumW + btnW + spance;
            [tmpArr removeAllObjects];
        }
        [tmpArr addObject:btn];
        num++;
        btnY = CGRectGetMaxY(titleView.frame) + spance + row * (btnH + spance);
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
//        NSLog(@"%d--%@",i,btn.titleLabel.text);
        [addView addSubview:btn];
    }
    
//    [self.view addSubview:addView];
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
