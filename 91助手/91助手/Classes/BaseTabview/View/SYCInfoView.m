//
//  SYCInfoView.m
//  91助手
//
//  Created by sycjyy on 15/12/7.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#define viewW self.bounds.size.width
#define viewH self.bounds.size.height
#define ScreenW [UIScreen mainScreen].bounds.size.width

#import "SYCInfoView.h"

#import "SYCAppMoreBaseItem.h"

@interface SYCInfoView()

@property (nonatomic, weak)UILabel *titleView;

@property (nonatomic, weak)UILabel *downView;

@property (nonatomic, weak)UILabel *classfyView;

@property (nonatomic, weak)UILabel *timeView;

@property (nonatomic, weak)UILabel *languageView;

@property (nonatomic, weak)UILabel *authorView;

@property (nonatomic, weak)UILabel *requiView;

@end

@implementation SYCInfoView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpAllChildView];
    }
    return self;
}

- (void)setUpAllChildView{
    UILabel *titleView = [[UILabel alloc] init];
    titleView.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:18];
    titleView.text = @"信息";
    _titleView = titleView;
    [self addSubview:titleView];
    
    UILabel *downView = [[UILabel alloc] init];
    _downView = downView;
    [self addSubview:downView];
    
    UILabel *classfyView = [[UILabel alloc] init];
    _classfyView = classfyView;
    [self addSubview:classfyView];
    
    UILabel *timeView = [[UILabel alloc] init];
    _timeView = timeView;
    [self addSubview:timeView];
    
    UILabel *languageView = [[UILabel alloc] init];
    _languageView = languageView;
    [self addSubview:languageView];
    
    UILabel *authorView = [[UILabel alloc] init];
    _authorView =authorView;
    [self addSubview:authorView];
    
    UILabel *requiView = [[UILabel alloc] init];
    requiView.numberOfLines = 0;
    _requiView =requiView;
    [self addSubview:requiView];

}

- (CGFloat)heightForInformationView{
//    NSLog(@"%f",CGRectGetMaxY(_requiView.frame));
    return CGRectGetMaxY(_requiView.frame);
}
- (void)setBaseItem:(SYCAppMoreBaseItem *)baseItem{
    _baseItem = baseItem;
    NSLog(@"one");
    [self layoutSubviews];
//    NSLog(@"%f",_requiView.frame.size.height);
    NSString *downStr = [NSString stringWithFormat:@"下   载 : %@下载",baseItem.downTimes];
    _downView.text = downStr;
    
    NSString *classStr = [NSString stringWithFormat:@"分   类 : %@",baseItem.cateName];
    _classfyView.text = classStr;
    
    NSString *timeStr = [NSString stringWithFormat:@"时   间 : %@",baseItem.updateTime];
    _timeView.text = timeStr;
    
    NSString *languageStr = [NSString stringWithFormat:@"语   言 : %@",baseItem.lan];
    _languageView.text = languageStr;
    
    NSString *authorStr = [NSString stringWithFormat:@"作   者 : %@",baseItem.author];
    _authorView.text = authorStr;
    
    NSString *requiStr = [NSString stringWithFormat:@"兼容性 : %@",baseItem.requirement];
    _requiView.text = requiStr;
    

//    [self layoutSubviews];
    CGFloat margin = 5;
    CGFloat X = 20;
    CGFloat W = ScreenW - 40;;
    CGFloat H = 15;
    CGFloat Y = 10;
    _titleView.frame = CGRectMake(X, Y, W, 20);
    _downView.frame = CGRectMake(X, CGRectGetMaxY(_titleView.frame)+margin, W, H);
    _classfyView.frame = CGRectMake(X, CGRectGetMaxY(_downView.frame)+margin, W, H);
    _timeView.frame = CGRectMake(X, CGRectGetMaxY(_classfyView.frame)+margin, W, H);
    _languageView.frame = CGRectMake(X, CGRectGetMaxY(_timeView.frame)+margin, W, H);
    _authorView.frame = CGRectMake(X, CGRectGetMaxY(_languageView.frame)+margin, W, H);
    //    [_requiView sizeToFit];
    CGSize requiSize =[_requiView.text boundingRectWithSize:CGSizeMake(ScreenW-40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
    CGFloat requiH = requiSize.height;
    NSLog(@"%f,%@",requiH,_requiView.text);
    _requiView.frame = CGRectMake(X, CGRectGetMaxY(_authorView.frame) + margin, ScreenW - 40, requiH);
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"text"]) {
        NSLog(@"%@",change);
    }
}

//- (void)layoutSubviews{
//    [super layoutSubviews];
//    NSLog(@"two");
////    NSLog(@"%s",__func__);
//    CGFloat margin = 5;
//    CGFloat X = 20;
//    CGFloat W = viewW - 40;;
//    CGFloat H = 15;
//    CGFloat Y = 10;
//    _titleView.frame = CGRectMake(X, Y, W, 20);
//    _downView.frame = CGRectMake(X, CGRectGetMaxY(_titleView.frame)+margin, W, H);
//    _classfyView.frame = CGRectMake(X, CGRectGetMaxY(_downView.frame)+margin, W, H);
//    _timeView.frame = CGRectMake(X, CGRectGetMaxY(_classfyView.frame)+margin, W, H);
//    _languageView.frame = CGRectMake(X, CGRectGetMaxY(_timeView.frame)+margin, W, H);
//    _authorView.frame = CGRectMake(X, CGRectGetMaxY(_languageView.frame)+margin, W, H);
////    [_requiView sizeToFit];
//    CGSize requiSize =[_requiView.text boundingRectWithSize:CGSizeMake(viewW-40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
//    CGFloat requiH = requiSize.height;
//    NSLog(@"%f,%@",requiH,_requiView.text);
//    _requiView.frame = CGRectMake(X, CGRectGetMaxY(_authorView.frame) + margin, viewW - 40, requiH);
//
//}
- (void)dealloc{
//    NSLog(@"%s,%@",__func__,[self class]);
//    [_baseItem removeObserver:self.requiView forKeyPath:@"text" context:nil];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
