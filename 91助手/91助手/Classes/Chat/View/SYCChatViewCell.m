//
//  SYCChatViewCell.m
//  91助手
//
//  Created by sycjyy on 15/12/9.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCChatViewCell.h"
#import "UIButton+WebCache.h"
#import "SYCChatItem.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width
@interface SYCChatViewCell()

@property (nonatomic, weak)UIButton *iconView;

@property (nonatomic, weak)UILabel *textView;

@end
@implementation SYCChatViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIButton *iconView = [UIButton buttonWithType:UIButtonTypeCustom];
        iconView.highlighted = NO;
        [iconView setImage:[UIImage imageNamed:@"six"] forState:UIControlStateNormal];
        _iconView = iconView;
        [self addSubview:iconView];
        UILabel *textView = [[UILabel alloc] init];
        textView.font = [UIFont systemFontOfSize:18];
        _textView= textView;
        [self addSubview:textView];
    }
    return self;
}

- (void)setItem:(SYCChatItem *)item{
    _item = item;
    _textView.text = item.name;
    
    [_iconView sd_setBackgroundImageWithURL:[NSURL URLWithString:item.icon] forState:UIControlStateNormal];
    [self layoutSubviews];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
//    CGFloat margin = 10;
    CGFloat iconX = 20;
    CGFloat iconY = 10;
    CGFloat iconW = 56;
    CGFloat iconH = 56;
    _iconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    CGFloat textX = CGRectGetMaxX(_iconView.frame)+20;
    CGFloat textW = self.bounds.size.width - 100;
    CGFloat textH = 30;
    CGFloat textY = iconY + iconH/2 -textH/2;
    _textView.frame = CGRectMake(textX, textY, textW, textH);
    

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
