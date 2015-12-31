//
//  SYCVLimitAndiMustewCell.m
//  91助手
//
//  Created by sycjyy on 15/12/1.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCVLimitAndiMustewCell.h"

#import "SYCAppButton.h"
#import "SYCAppBaseItem.h"


@interface SYCVLimitAndiMustewCell()<SYCAppButtonDelegate>

@property (nonatomic, weak)UIScrollView *scrollView;

@end
@implementation SYCVLimitAndiMustewCell

//- (SYCAppButton *)appBtn{
//    if (_appBtn == nil) {
//        _appBtn = [[SYCAppButton alloc] init];
//    }
//    return _appBtn;
//}

//- (void)setAppBtn:(SYCAppButton *)appBtn{
//    _appBtn = appBtn;
//    
//}

+ (instancetype)cellWithTableview:(UITableView *)tableview{
    static NSString *ID = @"cell";
    SYCVLimitAndiMustewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIScrollView *scrollView = [[UIScrollView alloc]init];
//        scrollView.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:scrollView];
        _scrollView = scrollView;
    }
    return self;
}

- (void)setItems:(NSArray *)items{
    _items = items;
    //这里会出现
    if (_scrollView.subviews) {
        for (UIView *view in _scrollView.subviews) {
            if ([view isKindOfClass:[SYCAppButton class]]) {
                [view removeFromSuperview];
            }
        }
    }
    [self setUpScrollViewSubviews:items];

}

- (void)setUpScrollViewSubviews:(NSArray *)items{
    
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = 60;
    CGFloat btnH = 70;
    CGFloat margin = 15;
    CGFloat scrollW = items.count * (btnW + margin) - margin;
    if (items.count > 10) {
        scrollW = 10*(btnW + margin) - margin;
    }
    _scrollView.contentSize = CGSizeMake(scrollW, btnH);
    _scrollView.autoresizesSubviews = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;

    for (int i = 0; i < items.count; i++) {
        if (i >= 10) {
            break;
        }
        SYCAppBaseItem *item = items[i];
        btnX = i * (btnW + margin);
        CGRect btnRect = CGRectMake(btnX, btnY, btnW, btnH);
        SYCAppButton *btn = [[SYCAppButton alloc] initWithFrame:btnRect];
        btn.delegate = self;
        btn.item = item;
        [_scrollView addSubview:btn];
    }
}

- (void)appButtonLinkToBaseView:(SYCAppBaseItem *)item{
    
    if ([_delegate respondsToSelector:@selector(appButtonLinkToBaseView:)]) {
        [_delegate appButtonLinkToBaseView:item];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat margin = 15;
    CGFloat scrollX = margin;
    CGFloat scrollY = margin;
    CGSize cellSize = self.bounds.size;
    CGFloat scrollH = cellSize.height - 2*margin;
    CGFloat scrollW = cellSize.width - 2*margin;
    _scrollView.frame = CGRectMake(scrollX, scrollY, scrollW, scrollH);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
