//
//  SYCAppSpecialViewCell.m
//  91助手
//
//  Created by sycjyy on 15/12/1.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCAppSpecialViewCell.h"

#import "SYCAppBaseItem.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

@interface SYCAppSpecialViewCell()

//@property (nonatomic, strong)NSMutableArray *btns;
@end
@implementation SYCAppSpecialViewCell

+ (instancetype)cellWithTableview:(UITableView *)tableview{
    static NSString *AsID = @"AScell";
    SYCAppSpecialViewCell *cell = [tableview dequeueReusableCellWithIdentifier:AsID];
    if (cell == nil) {
        cell =[[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:AsID];
    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.userInteractionEnabled = NO;
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpAllChildView];
    }
    return self;
}

- (void)setUpAllChildView{
    
    
    for (int i = 0 ; i < 4; i++) {
        UIButton *iconView = [UIButton buttonWithType:UIButtonTypeSystem];
        iconView.tag = i;
        iconView.highlighted = NO;
//        iconView.userInteractionEnabled = YES;
        [iconView addTarget:self action:@selector(clickIcon:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:iconView];
    }
}



- (void)clickIcon:(UIButton *)btn{
    SYCAppBaseItem *item = self.items[btn.tag];
    
    if ([_delegate respondsToSelector:@selector(appSpecialWithItem:)]) {
        [_delegate appSpecialWithItem:item];
    }
}

- (void)setItems:(NSArray *)items{
    _items = items;
    
    for (int i = 0; i < 4; i++) {
        UIButton *iconView = self.subviews[i+1];
        SYCAppBaseItem *item = items[i];
        [iconView sd_setBackgroundImageWithURL:[NSURL URLWithString:item.icon] forState:UIControlStateNormal];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat cellW = self.bounds.size.width;
    CGFloat margin = 15;
    CGFloat space = 5;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = (cellW - margin * 2 -space) / 2;
    CGFloat btnH = btnW * 0.7;
    int i = 0;
    for (UIView *iconView in self.subviews) {
        if ([iconView isKindOfClass:[UIButton class]]) {
            btnX = margin + (i%2) * (btnW + space);
            btnY = margin + (i/2) * (btnH + space);
            iconView.frame = CGRectMake(btnX, btnY, btnW, btnH);
            i++;
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
