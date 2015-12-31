//
//  SYCOpenBarView.m
//  91助手
//
//  Created by sycjyy on 15/12/4.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#define viewW self.bounds.size.width
#define viewH self.bounds.size.height

#import "SYCOpenBarView.h"

#import "SYCAppMoreBaseItem.h"
#import "UIImageView+WebCache.h"

@interface SYCOpenBarView()

@property (nonatomic, weak)UILabel *barView;

@property (nonatomic, weak)UIImageView *iconView;

@property (nonatomic, weak)UIScrollView *nameView;

@property (nonatomic, weak)UIImageView *starView;

@property (nonatomic, weak)UILabel *sizeView;

@property (nonatomic, weak)UILabel *editionView;

@property (nonatomic, weak)UIButton *priceView;

@property (nonatomic, weak)UIView *lineView;
@end
@implementation SYCOpenBarView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpAllChildView];
    }
    return self;
}

- (void)setUpAllChildView{
    //barView
    UILabel *barView = [[UILabel alloc] init];
    barView.font = [UIFont systemFontOfSize:20];
    barView.textColor = [UIColor grayColor];
    barView.textAlignment = UITextAlignmentCenter;
    barView.layer.borderColor = [[UIColor grayColor]CGColor];
    barView.layer.borderWidth = 1;
    _barView = barView;
    [self addSubview:barView];
    //iconView
    UIImageView *iconView = [[UIImageView alloc] init];
    _iconView = iconView;
    
    [self addSubview:iconView];
    //nameView
    UIScrollView *nameView = [[UIScrollView alloc] init];
    _nameView = nameView;
    [self addSubview:nameView];
    
    //starView
    UIImageView *starView = [[UIImageView alloc] init];
    _starView = starView;
    [self addSubview:starView];
    
    //sizeView
    UILabel *sizeView = [[UILabel alloc] init];
    sizeView.font = [UIFont systemFontOfSize:13];
    _sizeView = sizeView;
    [self addSubview:sizeView];
    
    //editionView
    UILabel *editionView = [[UILabel alloc] init];
    editionView.font = [UIFont systemFontOfSize:13];
    _editionView = editionView;
    
    [self addSubview:editionView];
    //priceView
    UIButton *priceView = [UIButton buttonWithType:UIButtonTypeCustom];
    [priceView setBackgroundImage:[UIImage imageNamed:@"btn_download_normal"] forState:UIControlStateNormal];
    [priceView setBackgroundImage:[UIImage imageNamed:@"btn_download_pressed"] forState:UIControlStateHighlighted];
    _priceView = priceView;
    [self addSubview:priceView];
    //lineView
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor grayColor];
    _lineView = lineView;
    [self addSubview:lineView];
    
}

- (void)setBaseItem:(SYCAppMoreBaseItem *)baseItem{
    _baseItem = baseItem;
    
    [self setUpData];
}

- (void)setUpData{
    //图标
    [_iconView sd_setImageWithURL:[NSURL URLWithString:_baseItem.icon] placeholderImage:[UIImage imageNamed:@"icon_default"]];
    
    //app名称
    UILabel *name = [[UILabel alloc] init];
    name.font = [UIFont systemFontOfSize:20];
    name.text = _baseItem.name;
    name.textColor = [UIColor whiteColor];
    [name sizeToFit];
    _nameView.contentSize = name.frame.size;
    [_nameView addSubview:name];
    
    //星数
    [self addStars:[_baseItem.star integerValue] forView:_starView];
    
    
    //应用大小
    NSString *sizeStr = [NSString stringWithFormat:@"大小:%.2fMB",[_baseItem.size floatValue]/(1024 * 1024)];
    _sizeView.text = sizeStr;
    
    //版本
    NSString *editStr = [NSString stringWithFormat:@"版本:%@",_baseItem.versionName];
    _editionView.text = editStr;
    
    //现价
    if ([_baseItem.price isEqualToString:@"0.00"]) {
        [_priceView setTitle:@"免费" forState:UIControlStateNormal];
        [_priceView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _priceView.enabled = YES;
    }else{
        [_priceView setTitle:_baseItem.price forState:UIControlStateNormal];
        [_priceView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _priceView.enabled = YES;
    }
    
    //bar
    NSString *barStr = [NSString stringWithFormat:@"打开%@吧",_baseItem.name];
    _barView.text = barStr;

}

#pragma mark - 给星级控件添加星
- (void)addStars:(NSInteger)starNum forView:(UIView *)view{
    CGFloat starX = 0;
    CGFloat starY = 0;
    CGFloat starW = 15;
    CGFloat starH = 14;
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


- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat margin = 15;
    CGFloat iconW = 80;
    CGFloat iconH = iconW;
    CGFloat iconX = margin;
    CGFloat iconY = -40;
    _iconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    CGFloat nameX = CGRectGetMaxX(_iconView.frame) + margin;
    CGFloat nameY = -30;
    CGFloat nameW = viewW - nameX - 2*margin;
    CGFloat nameH = 25;
    _nameView.frame = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat starX = nameX;
    CGFloat starY = 10;
    CGFloat starW = 90;
    CGFloat starH = 15;
    _starView.frame = CGRectMake(starX, starY, starW, starH);
    
    CGFloat sizeX = nameX;
    CGFloat sizeY = starH + starY;
    CGFloat sizeW = 100;
    CGFloat sizeH = 15;
    _sizeView.frame = CGRectMake(sizeX, sizeY, sizeW, sizeH);
    
    CGFloat editX = sizeX + sizeW + 5;
    CGFloat editY = sizeY;
    CGFloat editW = 80;
    CGFloat editH = sizeH;
    _editionView.frame = CGRectMake(editX, editY, editW, editH);
    
    CGFloat priceW = 50;
    CGFloat priceH = 24;
    CGFloat priceX = viewW - priceW - margin;
    CGFloat priceY = 10;
    _priceView.frame = CGRectMake(priceX, priceY, priceW, priceH);
    
    CGFloat barX = 55;
    CGFloat barY = 50;
    CGFloat barW = viewW - 110;
    CGFloat barH = 35;
    _barView.frame = CGRectMake(barX, barY, barW, barH);
    
    CGFloat lineX = 0;
    CGFloat lineY = viewH - 1;
    CGFloat lineW = viewW;
    CGFloat lineH = 1;
    _lineView.frame = CGRectMake(lineX, lineY, lineW, lineH);
}
@end
