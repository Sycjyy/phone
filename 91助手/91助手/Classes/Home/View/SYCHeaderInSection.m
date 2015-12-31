//
//  SYCHeaderInSection.m
//  91助手
//
//  Created by sycjyy on 15/12/2.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCHeaderInSection.h"
#import "SYCHomePart.h"

@interface SYCHeaderInSection()

@property (nonatomic ,weak)UIView * topView;

@property (nonatomic, weak)UILabel *nameView;

@property (nonatomic, weak)UIButton *moreView;

@property (nonatomic,strong)NSArray *moreUrls;
@end

@implementation SYCHeaderInSection

- (NSArray *)moreUrls{
    if (_moreUrls == nil) {
        NSString *xsmf = @"http://applebbx.sj.91.com/api/?act=236&cuid=3428d2caf0eb10eeb75f39d9d3ed91cdaaf5a419&spid=2&imei=612976FF-5EC4-4E9C-9C8F-A5689CB586C9&osv=8.4.1&dm=iPhone7,2&sv=3.1.3&top=15&mt=1&nt=10&pid=2";
        NSString *jptj = @"http://applebbx.sj.91.com/soft/phone/list.aspx?cuid=3428d2caf0eb10eeb75f39d9d3ed91cdaaf5a419&act=244&imei=612976FF-5EC4-4E9C-9C8F-A5689CB586C9&spid=2&osv=8.4.1&dm=iPhone7,2&sv=3.1.3&top=20&mt=1&nt=10&pid=2";
        NSString *zjbb = @"http://applebbx.sj.91.com/api/?act=236&cuid=3428d2caf0eb10eeb75f39d9d3ed91cdaaf5a419&spid=2&imei=612976FF-5EC4-4E9C-9C8F-A5689CB586C9&osv=8.4.1&dm=iPhone7,2&sv=3.1.3&top=15&mt=1&nt=10&pid=2";
        NSString *yyzt = @"http://applebbx.sj.91.com/soft/phone/tag.aspx?cuid=3428d2caf0eb10eeb75f39d9d3ed91cdaaf5a419&act=212&imei=612976FF-5EC4-4E9C-9C8F-A5689CB586C9&spid=2&osv=8.4.1&dm=iPhone7,2&sv=3.1.3&nt=10&mt=1&pid=2";
        NSString *hmcr = @"http://applebbx.sj.91.com/soft/phone/list.aspx?cuid=3428d2caf0eb10eeb75f39d9d3ed91cdaaf5a419&act=245&imei=612976FF-5EC4-4E9C-9C8F-A5689CB586C9&spid=2&osv=8.4.1&dm=iPhone7,2&sv=3.1.3&top=10&mt=1&nt=10&pid=2";
        NSString *bjtj = @"http://applebbx.sj.91.com/soft/phone/list.aspx?skip=10&mt=1&spid=2&osv=8.4.1&cuid=3428d2caf0eb10eeb75f39d9d3ed91cdaaf5a419&imei=612976FF-5EC4-4E9C-9C8F-A5689CB586C9&dm=iPhone7,2&sv=3.1.3&act=244&nt=10&pid=2&top=10";
        _moreUrls = @[xsmf,jptj,zjbb,yyzt,hmcr,bjtj];
    }
    return _moreUrls;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UIView *topView = [[UIView alloc] init];
        topView.backgroundColor = [UIColor colorWithRed:239/250.0 green:239/250.0 blue:239/250.0 alpha:1];
        [self addSubview:topView];
        _topView = topView;
        UILabel *nameView = [[UILabel alloc] init];
        nameView.font = [UIFont fontWithName:@"Helvetica" size:18.f];
        nameView.textColor = [UIColor blackColor];
        [self addSubview:nameView];
        _nameView = nameView;
        
        UIButton *moreView = [UIButton buttonWithType:UIButtonTypeSystem];
        [moreView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        moreView.titleLabel.font = [UIFont systemFontOfSize:15];
        [moreView setTitle:@"更多" forState:UIControlStateNormal];
        moreView.highlighted = NO;
        //增加点击事件
        [moreView addTarget:self action:@selector(loadMoreData) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:moreView];
        _moreView = moreView;
    }
    return self;
}

- (void)loadMoreData{
    if ([_delegate respondsToSelector:@selector(headerLoadMoreData:andUrl:andSection:)]) {
        [_delegate headerLoadMoreData:self.part andUrl:self.moreUrls[self.section] andSection:self.section];
    }
}

- (void)setPart:(SYCHomePart *)part{
    _part = part;
    _nameView.text = part.name;
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _topView.frame = CGRectMake(0, 0, self.bounds.size.width, 1);
    
    CGFloat margin = 15;
    
    _nameView.frame = CGRectMake(15, 0, 100, 30);
    
    CGFloat moreH = 18;
    CGFloat moreW = 35;
    CGFloat moreX = self.bounds.size.width - margin - moreW;
    CGFloat moreY = CGRectGetMaxY(_nameView.frame) - moreH;
    
    _moreView.frame = CGRectMake(moreX, moreY, moreW, moreH);
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
