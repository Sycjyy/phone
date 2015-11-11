//
//  GBCStatuscell.m
//  phoneAssistant
//
//  Created by Denny_cheng on 15/9/21.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import "GBCStatuscell.h"
#import "GBCStatusCellFrame.h"
#import "UIImageView+WebCache.h"

@interface GBCStatuscell ()
/**
 *  显示头像
 */
@property(nonatomic,weak) UIImageView *headerView;
/**
 *  显示名字
 */
@property (nonatomic,weak) UILabel *nameLal;
/**
 *  显示星级
 */
@property(nonatomic,weak) UILabel *starLal;
/**
 *  显示下载次数
 */
@property(nonatomic,weak) UILabel *downTimesLal;
/**
 *  显示大小
 */
@property(nonatomic,weak) UILabel *sizeLal;
/**
 *  显示button
 */
@property(nonatomic,weak) UIButton *freeBtn;
/**
 *  显示originalPrice
 */
@property(nonatomic,weak) UILabel *orignalLal;
/**
 *  显示price
 */
@property(nonatomic,weak) UILabel *price;


@end

@implementation GBCStatuscell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //创建头像view
        UIImageView *headerView=[[UIImageView alloc] init];
        [self.contentView addSubview:headerView];
        self.headerView=headerView;
        
        //创建namelable
        UILabel *nameLal=[[UILabel alloc] init];
        [nameLal setTextColor:[UIColor blackColor]];
        nameLal.font=[UIFont systemFontOfSize:15];
        //nameLal.backgroundColor=[UIColor redColor];
        [self.contentView addSubview:nameLal];
        self.nameLal=nameLal;
        
        //创建星级lal
        UILabel *starLal=[[UILabel alloc] init];
        [self.contentView addSubview:starLal];
        self.starLal=starLal;
        
        //创建下载lal
        UILabel *downLal=[[UILabel alloc] init];
        [downLal setTextColor:[UIColor blackColor]];
        downLal.font=[UIFont systemFontOfSize:13];
        //downLal.backgroundColor=[UIColor grayColor];
        [self.contentView addSubview:downLal];
        self.downTimesLal=downLal;
        
        //创建大小lal
        UILabel *sizeLal=[[UILabel alloc] init];
        [sizeLal setTextColor:[UIColor blackColor]];
        sizeLal.font=[UIFont systemFontOfSize:13];
        //sizeLal.backgroundColor=[UIColor greenColor];
        [self.contentView addSubview:sizeLal];
        self.sizeLal=sizeLal;
        
        //创建originalPricelal
        UILabel *originalPrice=[[UILabel alloc] init];
        originalPrice.textColor=[UIColor blackColor];
        originalPrice.font=[UIFont systemFontOfSize:12];
        [originalPrice setTextAlignment:NSTextAlignmentCenter];
        //originalPrice.backgroundColor=[UIColor greenColor];
        self.orignalLal=originalPrice;
        [self.contentView addSubview:originalPrice];
        
        //创建price
        UILabel *price=[[UILabel alloc] init];
        price.textColor=[UIColor blackColor];
        price.font=[UIFont systemFontOfSize:15];
        //price.backgroundColor=[UIColor greenColor];
        self.price=price;
        [self.contentView addSubview:price];
        
        //创建freebtn
        UIButton *freeBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
        [freeBtn setTitle:@"免费" forState:(UIControlStateNormal)];
        [freeBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        freeBtn.layer.cornerRadius=3;
        //freeBtn.layer.masksToBounds=YES;
        
        //freeBtn.font=[UIFont systemFontOfSize:18];
        freeBtn.backgroundColor=[UIColor orangeColor];
        [self.contentView addSubview:freeBtn];
        self.freeBtn=freeBtn;
    }
    return self;
}

- (void)setStatusCellFrame:(GBCStatusCellFrame *)statusCellFrame
{
    _statusCellFrame=statusCellFrame;
    GBCStatusHome *statusHome=statusCellFrame.statusHome;
    
    //赋headerView的frame
    self.headerView.frame=statusCellFrame.IconFrame;
    NSURL *url=[NSURL URLWithString:statusHome.icon];
    [self.headerView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"icon_leading"]];
    
    //赋name的frame
    self.nameLal.frame=statusCellFrame.NameFrame;
    self.nameLal.text=statusHome.name;
    
    //赋star的frame
    self.starLal.frame=statusCellFrame.StarFrame;
    NSString *starStr=statusHome.star;
    NSUInteger count=[starStr integerValue];
    NSUInteger width=15;
    for (int i=0; i<5; i++) {
        if (i<count) {
            NSUInteger x=i*width;
            UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(x, 0, width, width)];
            imgView.image=[UIImage imageNamed:@"detail_star"];
            [self.starLal addSubview:imgView];
        }
        if (i>=count) {
            NSUInteger x=i*width;
            UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(x, 0, width, width)];
            imgView.image=[UIImage imageNamed:@"detail_unstar"];
            [self.starLal addSubview:imgView];
        }
    }
    
    //赋downtimes的frame
    self.downTimesLal.frame=statusCellFrame.downTimesFrame;
    NSString *downStr=[NSString stringWithFormat:@"%@次下载",statusCellFrame.statusHome.downTimes];
    self.downTimesLal.text=downStr;
    
    //赋size的frame
    self.sizeLal.frame=statusCellFrame.sizeFrame;
    NSString *sizeStr=statusHome.size;
    NSUInteger size=[sizeStr integerValue];
    CGFloat sizeMB=size/1024.0/1024.0;
    NSString *sizeText=[NSString stringWithFormat:@"%.2fMB",sizeMB];
    self.sizeLal.text=sizeText;
    
    
    if (statusHome.originalPrice.length>4) {
        self.orignalLal.frame=statusCellFrame.originalFrame;
        self.orignalLal.text=statusHome.originalPrice;
        

    }
    if (statusHome.price.length<=4){
        self.orignalLal.frame=statusCellFrame.originalFrame;
        self.orignalLal.text=statusHome.originalPrice;
        
        self.freeBtn.frame=statusCellFrame.buttonFrame;

    }
    if (statusHome.price.length>4) {
        self.price.frame=statusCellFrame.priceFrame;
        self.price.text=statusHome.price;
    }
    
    //赋btn的frame
    //if (statusHome.price.length>4) {
//        self.price.frame=statusCellFrame.priceFrame;
//        self.price.text=statusHome.price;
    //}
//    else{
//        self.freeBtn.frame=statusCellFrame.buttonFrame;
//    }
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID=@"ID";
    GBCStatuscell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[GBCStatuscell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
    }
    return cell;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
