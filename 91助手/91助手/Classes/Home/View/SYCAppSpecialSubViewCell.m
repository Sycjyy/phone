//
//  SYCAppSpecialSubViewCell.m
//  91助手
//
//  Created by sycjyy on 15/12/2.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCAppSpecialSubViewCell.h"

#import "SYCAppBaseItem.h"
#import "UIImageView+WebCache.h"

@interface SYCAppSpecialSubViewCell()

@property (nonatomic, weak)UIImageView *iconView;

@property (nonatomic, weak)UILabel *nameView;

@property (nonatomic, weak)UILabel *summaryView;
@end

@implementation SYCAppSpecialSubViewCell

+ (instancetype)cellWithTableview:(UITableView *)tableview{
    static NSString *ASID = @"asCell";
    SYCAppSpecialSubViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ASID];
    if (cell == nil) {
        cell = [[SYCAppSpecialSubViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ASID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpAllChildViews];
    }
    return self;
}

- (void)setUpAllChildViews{
    UIImageView *iconView = [[UIImageView alloc] init];
    [self.contentView addSubview:iconView];
    _iconView = iconView;
    
    UILabel *nameView = [[UILabel alloc] init];
    nameView.font = [UIFont fontWithName:@"Helvetica" size:18.f];
    nameView.textColor = [UIColor blackColor];
    [self.contentView addSubview:nameView];
    _nameView = nameView;
    
    UILabel *summaryView = [[UILabel alloc] init];
    summaryView.textColor = [UIColor grayColor];
    summaryView.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:summaryView];
    _summaryView = summaryView;
}

- (void)setItem:(SYCAppBaseItem *)item{
    _item = item;
    
    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.icon]];
    
    _nameView.text = item.name;
    
    _summaryView.text = item.summary;
    
}


- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat margin = 8;
    CGSize cellSize = self.bounds.size;
    CGFloat iconW = cellSize.width - 2*margin;
    CGFloat iconH = iconW / 2;
    _iconView.frame = CGRectMake(margin, margin, iconW, iconH);
    
    CGFloat nameX = 2 *margin;
    CGFloat nameY = CGRectGetMaxY(_iconView.frame) + 2*margin;
    CGFloat nameW = iconW - margin;
    CGFloat nameH = 20;
    _nameView.frame = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat summaryX = nameX;
    CGFloat summaryY = CGRectGetMaxY(_nameView.frame) + margin;
    CGFloat summaryW = nameW;
    CGFloat summaryH = 15;
    _summaryView.frame = CGRectMake(summaryX, summaryY, summaryW, summaryH);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
