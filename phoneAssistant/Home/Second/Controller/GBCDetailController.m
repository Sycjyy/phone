//
//  GBCDetailController.m
//  phoneAssistant
//
//  Created by Denny_cheng on 15/10/1.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#define GBCFONT [UIFont systemFontOfSize:10]


#import "GBCDetailController.h"
#import "AFHTTPRequestOperationManager.h"
#import "UIImageView+WebCache.h"
#import "NSString+WYString.h"

@interface GBCDetailController ()
@property(nonatomic,strong) NSDictionary *detailDict;
@property(nonatomic,assign) NSUInteger clickNum;
@property(nonatomic,weak) UILabel *descLal;
@property(nonatomic,weak) UIButton *exBtn;
@property(nonatomic,weak) UIView *twoLineView;
@property(nonatomic,weak) UILabel *tjLal;
@property(nonatomic,weak) UIScrollView *buttomScroll;
@property(nonatomic,weak) UIView *thirdLineView;
@property(nonatomic,weak) UILabel *xxLal;
@property(nonatomic,weak) UILabel *downLal;
@property(nonatomic,weak) UILabel *cateLal;
@property(nonatomic,weak) UILabel *timeLal;
@property(nonatomic,weak) UILabel *lanLal;
@property(nonatomic,weak) UILabel *authorLal;
@property(nonatomic,weak) UILabel *requireLal;
@property(nonatomic,weak) UIScrollView *viewScroll;
@property(nonatomic,assign) CGFloat distanceHeight;

@end

@implementation GBCDetailController
- (NSDictionary *)detailDict
{
    if (_detailDict==nil) {
        _detailDict=[NSDictionary dictionary];
    }
    return _detailDict;
}
- (void)viewWillAppear:(BOOL)animated
{
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setButton];
    self.clickNum=0;
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self loadData];
}

- (void)setButton
{
    UIButton *leftButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"web_pre_nor"] forState:(UIControlStateNormal)];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"web_pre_pre"] forState:(UIControlStateHighlighted)];
    
    UIBarButtonItem *left=[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem=left;
    [leftButton addTarget:self action:@selector(pop) forControlEvents:(UIControlEventTouchUpInside)];
    
}

- (void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadData
{
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    [mgr GET:self.detailUrl parameters:nil success:^(AFHTTPRequestOperation * operation, NSDictionary * responseData) {
        NSDictionary *dict=responseData[@"Result"];
        self.detailDict=dict;
    [self settingView];

        
        
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        NSLog(@"错误是：%@",error.localizedDescription);
    }];
}

- (void)settingView
{
    CGSize size=[UIScreen mainScreen].bounds.size;
    NSUInteger padding=5;
    UIScrollView *viewScroll=[[UIScrollView alloc] init];
    self.viewScroll=viewScroll;
    viewScroll.frame=CGRectMake(0, 20, size.width, size.height-20);
    [self.view addSubview:viewScroll];
    
    //创建topscrollView
    UIScrollView *topScroll=[[UIScrollView alloc] init];
    topScroll.showsHorizontalScrollIndicator=NO;
    topScroll.bounces=NO;
    NSUInteger topScrollX=0;
    NSUInteger topScrollY=0;
    CGFloat topScrollW=size.width;
    CGFloat topScrollH=size.height/2.0;
    topScroll.frame=CGRectMake(topScrollX, topScrollY, topScrollW, topScrollH);
    NSArray *snapshots=self.detailDict[@"snapshots"];
    NSUInteger snapshotsCount=snapshots.count;
    topScroll.contentSize=CGSizeMake(((size.width-padding)/2+padding)*snapshotsCount, topScrollH);
    [viewScroll addSubview:topScroll];
    
    //topscrollview中的图片
    for (NSUInteger i=0; i<snapshotsCount; i++) {
        UIImageView *imgView=[[UIImageView alloc] init];;
        NSUInteger imgViewW=(size.width-padding)/2;
        CGFloat imgViewH=topScrollH;
        NSUInteger imgViewX=(imgViewW+padding)*i;
        NSUInteger imgViewY=topScrollY;
        imgView.frame=CGRectMake(imgViewX, imgViewY, imgViewW, imgViewH);
        NSURL *url=[NSURL URLWithString:snapshots[i]];
        //NSLog(@"fghytuuuu");
        [imgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"detail_image_default"]];
        [topScroll addSubview:imgView];
    }
    
    //icon图片
    UIImageView *imgIcon=[[UIImageView alloc] init];
    NSUInteger imgIconX=10;
    NSUInteger imgIconW=100;
    NSUInteger imgIconH=imgIconW;
    NSInteger imgIconY=CGRectGetMaxY(topScroll.frame)-imgIconW/2;
    imgIcon.frame=CGRectMake(imgIconX, imgIconY, imgIconW, imgIconH);
    //NSString *imgStr=self.detailDict[@"icon"];
    NSURL *url=[NSURL URLWithString:self.detailDict[@"icon"]];
    [imgIcon sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"icon"]];
    [viewScroll addSubview:imgIcon];
    
    //星级lal
    UILabel *starLal=[[UILabel alloc] init];
    NSUInteger starLalX=CGRectGetMaxX(imgIcon.frame)+padding;
    NSUInteger starLalY=CGRectGetMaxY(topScroll.frame)+3*padding;
    NSUInteger starLalW=50;
    NSUInteger starLalH=10;
    starLal.frame=CGRectMake(starLalX, starLalY, starLalW, starLalH);
    
    NSUInteger imgStarY=0;
    NSUInteger imgStarW=starLalH;
    NSUInteger imgStarH=imgStarW;
    NSString *starStr=self.detailDict[@"star"];
    NSUInteger starCount=[starStr integerValue];
    for (NSUInteger i=0; i<starCount; i++) {
        UIImageView *imgStar=[[UIImageView alloc] init];
        imgStar.image=[UIImage imageNamed:@"detail_star"];
        NSUInteger imgStarX=starLalH*i;
        imgStar.frame=CGRectMake(imgStarX, imgStarY, imgStarW, imgStarH);
        [starLal addSubview:imgStar];
    }
    for (NSUInteger i=starCount; i<5; i++) {
        UIImageView *imgStar=[[UIImageView alloc] init];
        imgStar.image=[UIImage imageNamed:@"detail_unstar"];
        NSUInteger imgStarX=starLalH*i;
        imgStar.frame=CGRectMake(imgStarX, imgStarY, imgStarW, imgStarH);
        [starLal addSubview:imgStar];
    }
    [viewScroll addSubview:starLal];
    
    //大小lal
    NSString *sizeStr=self.detailDict[@"size"];
    NSUInteger sizeCount=[sizeStr integerValue];
    UILabel *sizeLal=[[UILabel alloc] init];
    //[sizeLal setTextColor:[UIColor blackColor]];
    NSString *sizeText=[NSString stringWithFormat:@"大小:%zdMB",sizeCount/1024/1024];
    sizeLal.text=sizeText;
    [sizeLal setFont:[UIFont systemFontOfSize:10]];
    NSUInteger sizeLalX=starLalX;
    NSUInteger sizeLalY=CGRectGetMaxY(starLal.frame)+2*padding;
    NSUInteger sizeLalW=60;
    NSUInteger sizeLalH=starLalH;
    sizeLal.frame=CGRectMake(sizeLalX, sizeLalY, sizeLalW, sizeLalH);
    [viewScroll addSubview:sizeLal];
    
    //版本lal
    UILabel *versionLal=[[UILabel alloc] init];
    //versionLal.textColor=[UIColor blackColor];
    NSString *versionStr=[NSString stringWithFormat:@"版本:%@",self.detailDict[@"versionName"]];
    versionLal.text=versionStr;
    //versionLal.backgroundColor=[UIColor redColor];
    [versionLal setFont:[UIFont systemFontOfSize:10]];
    NSUInteger versionLalX=CGRectGetMaxX(sizeLal.frame)+padding;
    NSUInteger versionLalY=sizeLalY;
    NSUInteger versionLalW=70;
    NSUInteger versionH=sizeLalH;
    versionLal.frame=CGRectMake(versionLalX, versionLalY, versionLalW, versionH);
    [viewScroll addSubview:versionLal];
    
    
    //价格按钮
    NSString *freeStr=self.detailDict[@"price"];
    UIButton *freeBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    //freeBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [freeBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [freeBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateHighlighted)];
    freeBtn.backgroundColor=[UIColor orangeColor];
    NSString *priceStr=@"0.00";
    if ([freeStr isEqualToString:priceStr]) {
        [freeBtn setTitle:@"免费" forState:(UIControlStateNormal)];
        [freeBtn setTitle:@"免费" forState:(UIControlStateHighlighted)];
        freeBtn.layer.cornerRadius=5;
        
    }else{
        [freeBtn setTitle:self.detailDict[@"price"] forState:(UIControlStateNormal)];
        [freeBtn setTitle:self.detailDict[@"price"] forState:(UIControlStateHighlighted)];
    }
    NSUInteger freeBtnW=50;
    NSUInteger freeBtnX=size.width-10-freeBtnW;
    NSUInteger freeBtnY=CGRectGetMaxY(topScroll.frame)+15;
    NSUInteger freeBtnH=30;
    freeBtn.frame=CGRectMake(freeBtnX, freeBtnY, freeBtnW, freeBtnH);
    [viewScroll addSubview:freeBtn];
    
    //name
    UILabel *nameLal=[[UILabel alloc] init];
    nameLal.text=self.detailDict[@"name"];
    //nameLal.font=[UIFont systemFontOfSize:20];
    //nameLal.textColor=[UIColor blackColor];
    [nameLal setTextAlignment:NSTextAlignmentCenter];
    NSUInteger nameLalX=0;
    NSUInteger nameLalY=CGRectGetMaxY(imgIcon.frame)+3*padding;
    NSUInteger nameLalW=size.width;
    NSUInteger nameLalH=30;
    nameLal.frame=CGRectMake(nameLalX, nameLalY, nameLalW, nameLalH);
    [viewScroll addSubview:nameLal];
    
    //第一条分割线
    UIView *oneLineView=[[UIView alloc] init];
    oneLineView.backgroundColor=[UIColor grayColor];
    CGFloat oneLineViewX=0;
    CGFloat onelineViewY=CGRectGetMaxY(nameLal.frame)+3*padding;
    CGFloat oneLineViewW=size.width;
    CGFloat oneLineViewH=0.5;
    oneLineView.frame=CGRectMake(oneLineViewX, onelineViewY, oneLineViewW, oneLineViewH);
    [viewScroll addSubview:oneLineView];
    
    //应用简介
    UILabel *yyjjLal=[[UILabel alloc] init];
    //yyjjLal.backgroundColor=[UIColor redColor];
    //yyjjLal.textColor=[UIColor blackColor];
    yyjjLal.text=@"应用简介";
    CGFloat yyjjX=20;
    CGFloat yyjjY=CGRectGetMaxY(oneLineView.frame)+padding;
    CGFloat yyjjW=70;
    CGFloat yyjjH=20;
    yyjjLal.frame=CGRectMake(yyjjX, yyjjY, yyjjW, yyjjH);
    [viewScroll addSubview:yyjjLal];
    
    //简介内容
    UILabel *descLal=[[UILabel alloc] init];
    self.descLal=descLal;
    descLal.text=self.detailDict[@"desc"];
    [descLal setTextColor:[UIColor blackColor]];
    descLal.numberOfLines=0;
    descLal.font=[UIFont systemFontOfSize:10];
    CGFloat descLalX=yyjjX;
    CGFloat descLalY=CGRectGetMaxY(yyjjLal.frame);
    CGFloat descLalW=size.width-2*yyjjX;
    CGFloat descLalH=30;
    descLal.frame=CGRectMake(descLalX, descLalY, descLalW, descLalH);
    [viewScroll addSubview:descLal];
    
    CGFloat realHeight=[self.detailDict[@"desc"] calcSizeWithFont:GBCFONT maxWith:descLalW].height;
    self.distanceHeight=realHeight-descLalH;
    
    //展开按钮
    UIButton *exbtn=[[UIButton alloc] init];
    self.exBtn=exbtn;
    [exbtn addTarget:self action:@selector(showDetailJj) forControlEvents:(UIControlEventTouchUpInside)];
    [exbtn setTitle:@"展开" forState:(UIControlStateNormal)];
    [exbtn setTitle:@"展开" forState:(UIControlStateHighlighted)];
    [exbtn setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    [exbtn setTitleColor:[UIColor blueColor] forState:(UIControlStateHighlighted)];
    CGFloat exBtnW=50;
    CGFloat exBtnH=20;
    CGFloat exBtnY=CGRectGetMaxY(descLal.frame);
    CGFloat exBtnX=size.width-exBtnW-30;
    exbtn.frame=CGRectMake(exBtnX, exBtnY, exBtnW, exBtnH);
    [viewScroll addSubview:exbtn];
    
    //第二条分割线
    UIView *twoLineView=[[UIView alloc] init];
    self.twoLineView=twoLineView;
    twoLineView.backgroundColor=[UIColor grayColor];
    CGFloat twoLineViewX=0;
    CGFloat twoLineViewW=size.width;
    CGFloat twoLineViewH=0.5;
    CGFloat twoLineViewY=CGRectGetMaxY(exbtn.frame);
    twoLineView.frame=CGRectMake(twoLineViewX, twoLineViewY, twoLineViewW, twoLineViewH);
    [viewScroll addSubview:twoLineView];
    
    //推荐（ 还下载其他的）
    UILabel *tjLal=[[UILabel alloc] init];
    self.tjLal=tjLal;
    tjLal.text=@"下载此应用的人也下载了";
    [tjLal setTextColor:[UIColor blackColor]];
    CGFloat tjLalX=yyjjX;
    CGFloat tjLalY=CGRectGetMaxY(twoLineView.frame)+padding;
    CGFloat tjLalW=200;
    CGFloat tjLalH=20;
    tjLal.frame=CGRectMake(tjLalX, tjLalY, tjLalW, tjLalH);
    [viewScroll addSubview:tjLal];
    
    //buttomScroll
    UIScrollView *buttomScroll=[[UIScrollView alloc] init];
    self.buttomScroll=buttomScroll;
    buttomScroll.bounces=NO;
    buttomScroll.showsHorizontalScrollIndicator=NO;
    CGFloat buttomScrollY=CGRectGetMaxY(tjLal.frame)+2*padding;
    CGFloat buttomScrollH=60;
    buttomScroll.frame=CGRectMake(0, buttomScrollY, size.width, buttomScrollH);
    NSArray *tjArr=self.detailDict[@"recommendSofts"];
    [viewScroll addSubview:buttomScroll];
    
    CGFloat imgBtnH=buttomScrollH;
    CGFloat imgBtnW=imgBtnH;
    for (NSUInteger i=0; i<tjArr.count; i++) {
        UIButton *imgBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        imgBtn.tag=i;
        
        CGFloat imgBtnX=(10+imgBtnW)*i+10;
        imgBtn.frame=CGRectMake(imgBtnX, 0, imgBtnW, imgBtnH);
        NSURL *url=[NSURL URLWithString:tjArr[i][@"icon"]];
        NSData *urlData=[NSData dataWithContentsOfURL:url];
        [imgBtn setBackgroundImage:[UIImage imageWithData:urlData] forState:UIControlStateNormal];
        [imgBtn setBackgroundImage:[UIImage imageWithData:urlData] forState:UIControlStateHighlighted];
        [buttomScroll addSubview:imgBtn];
    }
    buttomScroll.contentSize=CGSizeMake((imgBtnW+10)*tjArr.count+10, buttomScrollH);
    
    //第三条线
    UIView *thirdLineView=[[UIView alloc] init];
    self.thirdLineView=thirdLineView;
    thirdLineView.backgroundColor=[UIColor grayColor];
    CGFloat thirdLineViewX=0;
    CGFloat thirdLineViewY=CGRectGetMaxY(buttomScroll.frame)+2*padding;
    CGFloat thirdLineViewW=size.width;
    CGFloat thirdLineViewH=0.5;
    thirdLineView.frame=CGRectMake(thirdLineViewX, thirdLineViewY, thirdLineViewW, thirdLineViewH);
    [viewScroll addSubview:thirdLineView];
    
    //信息
    UILabel *xxLal=[[UILabel alloc] init];
    self.xxLal=xxLal;
    xxLal.text=@"信息";
    [xxLal setTextColor:[UIColor blackColor]];
    CGFloat xxLalX=2*padding;
    CGFloat xxLalY=CGRectGetMaxY(thirdLineView.frame)+padding;
    CGFloat xxLalW=40;
    CGFloat xxLalH=20;
    xxLal.frame=CGRectMake(xxLalX, xxLalY, xxLalW, xxLalH);
    [viewScroll addSubview:xxLal];
    
    //下载
    UILabel *downLal=[[UILabel alloc] init];
    self.downLal=downLal;
    NSString *downStr=[NSString stringWithFormat:@"下  载：%@次下载",self.detailDict[@"downTimes"]];
    downLal.textColor=[UIColor blackColor];
    downLal.text=downStr;
    downLal.font=[UIFont systemFontOfSize:10];
    CGFloat downLalH=starLalH;
    CGFloat downLalW=150;
    CGFloat downLalX=xxLalX;
    CGFloat downLalY=CGRectGetMaxY(xxLal.frame)+padding;
    downLal.frame=CGRectMake(downLalX, downLalY, downLalW, downLalH);
    [viewScroll addSubview:downLal];
    
    //分类
    UILabel *cateLal=[[UILabel alloc] init];
    self.cateLal=cateLal;
    NSString *cateStr=[NSString stringWithFormat:@"分  类：%@",self.detailDict[@"cateName"]];
    cateLal.textColor=[UIColor blackColor];
    cateLal.text=cateStr;
    cateLal.font=[UIFont systemFontOfSize:10];
    CGFloat cateLalH=downLalH;
    CGFloat cateLalW=downLalW;
    CGFloat cateLalX=downLalX;
    CGFloat cateLalY=CGRectGetMaxY(downLal.frame)+padding;
    cateLal.frame=CGRectMake(cateLalX, cateLalY, cateLalW, cateLalH);
    [viewScroll addSubview:cateLal];
    
    //时间
    UILabel *timeLal=[[UILabel alloc] init];
    self.timeLal=timeLal;
    NSString *timeStr=[NSString stringWithFormat:@"时  间：%@",self.detailDict[@"updateTime"]];
    timeLal.text=timeStr;
    timeLal.textColor=[UIColor blackColor];
    timeLal.font=[UIFont systemFontOfSize:10];
    CGFloat timeLalX=downLalX;
    CGFloat timeLalW=downLalW;
    CGFloat timeLalH=downLalH;
    CGFloat timeLalY=CGRectGetMaxY(cateLal.frame)+padding;
    timeLal.frame=CGRectMake(timeLalX, timeLalY, timeLalW, timeLalH);
    [viewScroll addSubview:timeLal];
    
    //语言
    UILabel *lanLal=[[UILabel alloc] init];
    self.lanLal=lanLal;
    NSString *lanStr=[NSString stringWithFormat:@"语  言：%@",self.detailDict[@"lan"]];
    lanLal.text=lanStr;
    lanLal.textColor=[UIColor blackColor];
    lanLal.font=[UIFont systemFontOfSize:10];
    CGFloat lanLalX=downLalX;
    CGFloat lanLalW=downLalW;
    CGFloat lanLalH=downLalH;
    CGFloat lanLalY=CGRectGetMaxY(timeLal.frame)+padding;
    lanLal.frame=CGRectMake(lanLalX, lanLalY, lanLalW, lanLalH);
    [viewScroll addSubview:lanLal];
    
    //作者
    UILabel *authorLal=[[UILabel alloc] init];
    self.authorLal=authorLal;
    NSString *authorStr=[NSString stringWithFormat:@"作  者：%@",self.detailDict[@"author"]];
    authorLal.text=authorStr;
    authorLal.textColor=[UIColor blackColor];
    authorLal.font=[UIFont systemFontOfSize:10];
    CGFloat authorLalX=downLalX;
    CGFloat authorLalW=downLalW;
    CGFloat authorLalH=downLalH;
    CGFloat authorLalY=CGRectGetMaxY(lanLal.frame)+padding;
    authorLal.frame=CGRectMake(authorLalX, authorLalY, authorLalW, authorLalH);
    [viewScroll addSubview:authorLal];
    
    //要求及内容
    UILabel *requireLal=[[UILabel alloc] init];
    self.requireLal=requireLal;
    //requireLal.backgroundColor=[UIColor redColor];
    NSString *requireStr=[NSString stringWithFormat:@"要  求：%@",self.detailDict[@"requirement"]];
    requireLal.text=requireStr;
    requireLal.numberOfLines=0;
    requireLal.textColor=[UIColor blackColor];
    requireLal.font=GBCFONT;
    CGFloat requireX=downLalX;
    CGFloat requireW=size.width-2*downLalX;
    CGSize requireSize=[requireStr calcSizeWithFont:GBCFONT maxWith:requireW];
    CGFloat requireH=requireSize.height;
    CGFloat requireY=CGRectGetMaxY(authorLal.frame)+4;
    requireLal.frame=CGRectMake(requireX, requireY, requireW, requireH);
    [viewScroll addSubview:requireLal];
    
    viewScroll.contentSize=CGSizeMake(size.width, CGRectGetMaxY(requireLal.frame));

    [self.view addSubview:viewScroll];
    
    //返回按钮
    UIButton *returnBtn=[UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    returnBtn.frame=CGRectMake(20, 20, 36, 36);
    [returnBtn setBackgroundImage:[UIImage imageNamed:@"detail_back_normal"] forState:(UIControlStateNormal)];
    [returnBtn setBackgroundImage:[UIImage imageNamed:@"detail_back_press"] forState:(UIControlStateHighlighted)];
    [self.view addSubview:returnBtn];
    [returnBtn addTarget:self action:@selector(dismiss) forControlEvents:(UIControlEventTouchUpInside)];
}
- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)showDetailJj
{
    CGFloat distanceWidth=self.distanceHeight;
    CGRect rect;
    if (self.clickNum==0) {
        
        //desc内容高度的变化
        rect=self.descLal.frame;
        rect.size.height+=distanceWidth;
        self.descLal.frame=rect;
        
        //展开位置的变化
        rect=self.exBtn.frame;
        rect.origin.y+=distanceWidth;
        self.exBtn.frame=rect;
        [self.exBtn setTitle:@"收起" forState:(UIControlStateNormal)];
        [self.exBtn setTitle:@"收起" forState:(UIControlStateHighlighted)];
        
        //第二条线的变化
        rect=self.twoLineView.frame;
        rect.origin.y+=distanceWidth;
        self.twoLineView.frame=rect;
        
        //推荐的变化
        rect=self.tjLal.frame;
        rect.origin.y+=distanceWidth;
        self.tjLal.frame=rect;
        
        //buttomscroll的变化
        rect=self.buttomScroll.frame;
        rect.origin.y+=distanceWidth;
        self.buttomScroll.frame=rect;
        
        //第三条线的变化
        rect=self.thirdLineView.frame;
        rect.origin.y+=distanceWidth;
        self.thirdLineView.frame=rect;
        
        //信息的变化
        rect=self.xxLal.frame;
        rect.origin.y+=distanceWidth;
        self.xxLal.frame=rect;
        
        //下载
        rect=self.downLal.frame;
        rect.origin.y+=distanceWidth;
        self.downLal.frame=rect;
        
        //分类
        rect=self.cateLal.frame;
        rect.origin.y+=distanceWidth;
        self.cateLal.frame=rect;
        
        //时间
        rect=self.timeLal.frame;
        rect.origin.y+=distanceWidth;
        self.timeLal.frame=rect;
        
        //语言
        rect=self.lanLal.frame;
        rect.origin.y+=distanceWidth;
        self.lanLal.frame=rect;
        
        //作者
        rect=self.authorLal.frame;
        rect.origin.y+=distanceWidth;
        self.authorLal.frame=rect;
        
        //要求
        rect=self.requireLal.frame;
        rect.origin.y+=distanceWidth;
        self.requireLal.frame=rect;
        CGSize size=[UIScreen mainScreen].bounds.size;
        self.viewScroll.contentSize=CGSizeMake(size.width, CGRectGetMaxY(self.requireLal.frame));
        self.clickNum=1;
        
    }else if (self.clickNum==1){
        //self.clickNum=0;
        //desc内容高度的变化
        rect=self.descLal.frame;
        rect.size.height-=distanceWidth;
        self.descLal.frame=rect;
        
        //展开位置的变化
        rect=self.exBtn.frame;
        rect.origin.y-=distanceWidth;
        self.exBtn.frame=rect;
        [self.exBtn setTitle:@"展开" forState:(UIControlStateNormal)];
        [self.exBtn setTitle:@"展开" forState:(UIControlStateHighlighted)];

        
        //第二条线的变化
        rect=self.twoLineView.frame;
        rect.origin.y-=distanceWidth;
        self.twoLineView.frame=rect;
        
        //推荐的变化
        rect=self.tjLal.frame;
        rect.origin.y-=distanceWidth;
        self.tjLal.frame=rect;
        
        //buttomscroll的变化
        rect=self.buttomScroll.frame;
        rect.origin.y-=distanceWidth;
        self.buttomScroll.frame=rect;
        
        //第三条线的变化
        rect=self.thirdLineView.frame;
        rect.origin.y-=distanceWidth;
        self.thirdLineView.frame=rect;
        
        //信息的变化
        rect=self.xxLal.frame;
        rect.origin.y-=distanceWidth;
        self.xxLal.frame=rect;
        
        //下载
        rect=self.downLal.frame;
        rect.origin.y-=distanceWidth;
        self.downLal.frame=rect;
        
        //分类
        rect=self.cateLal.frame;
        rect.origin.y-=distanceWidth;
        self.cateLal.frame=rect;
        
        //时间
        rect=self.timeLal.frame;
        rect.origin.y-=distanceWidth;
        self.timeLal.frame=rect;
        
        //语言
        rect=self.lanLal.frame;
        rect.origin.y-=distanceWidth;
        self.lanLal.frame=rect;
        
        //作者
        rect=self.authorLal.frame;
        rect.origin.y-=distanceWidth;
        self.authorLal.frame=rect;
        
        //要求
        rect=self.requireLal.frame;
        rect.origin.y-=distanceWidth;
        self.requireLal.frame=rect;
        CGSize size=[UIScreen mainScreen].bounds.size;
        self.viewScroll.contentSize=CGSizeMake(size.width, CGRectGetMaxY(self.requireLal.frame));
        self.clickNum=0;
    }else{
    
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
