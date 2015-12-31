//
//  SYCLoadListViewCell.m
//  91助手
//
//  Created by sycjyy on 15/11/30.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCLoadListViewCell.h"

#import "SYCAppBaseItem.h"
#import "UIImageView+WebCache.h"


#define SYCDownTimesFont [UIFont systemFontOfSize:14]
#define SYCAppNameFont [UIFont systemFontOfSize:17]
#define SYCOriginalPriceFont [UIFont systemFontOfSize:11]


@interface SYCLoadListViewCell()
//icon
@property (nonatomic, weak)UIImageView *iconView;
//name
@property (nonatomic, weak)UILabel *nameView;
//originalPrice
@property (nonatomic, weak)UILabel *origPriceView;
//price
@property (nonatomic, weak)UIButton *priceView;
//star
@property (nonatomic, weak)UIImageView *starView;
//downTimes
@property (nonatomic, weak)UILabel *downTimesView;
//size
@property (nonatomic, weak)UILabel *sizeView;

@end

@implementation SYCLoadListViewCell

+ (instancetype)cellWithTableview:(UITableView *)tableview{
    static NSString *baseID = @"baseCell";
    SYCLoadListViewCell *cell = [tableview dequeueReusableCellWithIdentifier:baseID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:baseID];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpAllChildView];
    }
    return self;
}
#pragma mark - 添加所有的控件
- (void)setUpAllChildView{
    //iconView
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    _iconView = iconView;
    
    //nameView
    UILabel *nameView = [[UILabel alloc] init];
    nameView.font = SYCAppNameFont;
    [self addSubview:nameView];
    _nameView = nameView;
    
    //originalPriceView
    UILabel *origPriceView = [[UILabel alloc] init];
    origPriceView.font = SYCOriginalPriceFont;
    origPriceView.textAlignment = NSTextAlignmentCenter;
    [self addSubview:origPriceView];
    _origPriceView = origPriceView;
    
    //priceView
    UIButton *priceView = [UIButton buttonWithType:UIButtonTypeCustom];
    priceView.hidden = NO;
    [priceView addTarget:self action:@selector(linkToAppStore:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:priceView];
    _priceView = priceView;
    
    //starView
    UIImageView *starView = [[UIImageView alloc] init];
    [self addSubview:starView];
    _starView = starView;
    
    //downTimesView
    UILabel *downTimesView = [[UILabel alloc] init];
    downTimesView.font = SYCDownTimesFont;
    [self addSubview:downTimesView];
    _downTimesView = downTimesView;
    
    //sizeView
    UILabel *sizeView = [[UILabel alloc] init];
    sizeView.font = SYCDownTimesFont;
    [self addSubview:sizeView];
    _sizeView = sizeView;
}

#pragma mark - 连接到App Store
- (void)linkToAppStore:(NSString *)URLStr{
    NSLog(@"连接到App Store");
}

- (void)setItem:(SYCAppBaseItem *)item{
    _item = item;
    //设置数据
    [self setUpData];
}

#pragma mark - 根据传过来的值设置控件的内容
- (void)setUpData{
    
    //图标
    [_iconView sd_setImageWithURL:[NSURL URLWithString:_item.icon] placeholderImage:[UIImage imageNamed:@"icon_default"]];
    
    //app名称
    _nameView.text = _item.name;
    
    //星数
    [self addStars:[_item.star integerValue] forView:_starView];
    
    //下载次数
    NSString *downTimes = [NSString stringWithFormat:@"%@次下载",_item.downTimes];
    _downTimesView.text = downTimes;

    //应用大小
    NSString *sizeStr = [NSString stringWithFormat:@"%.2fMB",[_item.size floatValue]/(1024 * 1024)];
    _sizeView.text = sizeStr;
    
    //原价
    if ([_item.originalPrice isEqualToString:@"0.00"]) {
        _origPriceView.hidden = YES;
       
    }else{
        UIImageView *desLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"des_line"]];
        desLine.frame = CGRectMake(5, 8, 40, 1);
        [_origPriceView addSubview:desLine];
        _origPriceView.hidden = NO;
        _origPriceView.text = _item.originalPrice;
    }
    
    //现价
    if ([_item.price isEqualToString:@"0.00"]) {
        [_priceView setBackgroundImage:[UIImage imageNamed:@"btn_download_normal"] forState:UIControlStateNormal];
        [_priceView setBackgroundImage:[UIImage imageNamed:@"btn_download_pressed"] forState:UIControlStateHighlighted];
        [_priceView setTitle:@"免费" forState:UIControlStateNormal];
        [_priceView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _priceView.enabled = YES;
    }else{
        [_priceView setBackgroundImage:nil forState:UIControlStateNormal];
        [_priceView setTitle:_item.price forState:UIControlStateNormal];
        [_priceView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _priceView.enabled = NO;
    }
}
#pragma mark - 给星级控件添加星
- (void)addStars:(NSInteger)starNum forView:(UIView *)view{
    CGFloat starX = 0;
    CGFloat starY = 0;
    CGFloat starW = 12;
    CGFloat starH = 11;
    CGFloat margin = 5;
    for (int i = 0; i < 5; i++) {
        if (i < starNum) {
            UIImageView *star = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"detail_star"]];
            starX = i * (starW + margin);
            star.frame = CGRectMake(starX, starY, starW, starH);
            [view addSubview:star];
        }else{
            UIImageView *star = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"detail_unstar"]];
            starX = i * (starW + margin);
            star.frame = CGRectMake(starX, starY, starW, starH);
            [view addSubview:star];
        }
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat marginH = 5;
    CGFloat marginW = 15;
    
    //icon
    CGFloat iconX = marginW;
    CGFloat iconY = marginH;
    CGFloat iconWH = 57;
    _iconView.frame = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    //name
    CGFloat nameX = CGRectGetMaxX(_iconView.frame) + marginW -2;
    CGFloat nameY = iconY;
    CGFloat nameH = 17;
    CGFloat nameW = 190;//有待修改
    _nameView.frame = CGRectMake(nameX, nameY, nameW, nameH);
    
    //star
    CGFloat starX = nameX;
    CGFloat starY = CGRectGetMaxY(_nameView.frame) + marginH;
    CGFloat starH = 14;
    CGFloat starW = 72;
    _starView.frame = CGRectMake(starX, starY, starW, starH);
    
    //downTimes
    [_downTimesView sizeToFit];
    CGSize downSize = _downTimesView.frame.size;
    CGFloat downX = nameX;
    CGFloat downY = CGRectGetMaxY(_iconView.frame) - downSize.height;
    _downTimesView.frame = (CGRect){{downX,downY},downSize};
    
    //size
    CGFloat sizeX = CGRectGetMaxX(_downTimesView.frame) + marginW;
    CGFloat sizeY = downY;
    CGFloat sizeH = 15;
    CGFloat sizeW = 70;
    _sizeView.frame = CGRectMake(sizeX, sizeY, sizeW, sizeH);
    
    //originalPrice
    CGFloat originW = 50;
    CGFloat originH = 16;//修改调整
    CGFloat originX = self.bounds.size.width - originW - marginW;
    CGFloat originY = marginH;
    _origPriceView.frame = CGRectMake(originX, originY, originW, originH);
    
    //price
    [_priceView sizeToFit];
    CGSize priceSize = _priceView.frame.size;
    CGFloat priceX = self.bounds.size.width - priceSize.width - marginW;
    CGFloat priceY = CGRectGetMaxY(_origPriceView.frame);
    _priceView.frame = (CGRect){{priceX,priceY},priceSize};
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
