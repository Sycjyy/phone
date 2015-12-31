//
//  SYCAppBaseViewController.m
//  91助手
//
//  Created by sycjyy on 15/12/3.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//
#define viewW self.view.frame.size.width
#define viewH self.view.frame.size.height

#import "SYCAppBaseViewController.h"
#import "SYCDataRequestTool.h"

#import "SYCImageDisplayView.h"
#import "SYCOpenBarView.h"
#import "SYCAppIntroduceView.h"
#import "SYCAppRecomView.h"
#import "SYCInfoView.h"

#import "SYCAppBaseItem.h"
#import "SYCAppMoreBaseItem.h"

@interface SYCAppBaseViewController ()<SYCAppIntroduceViewDelegate,SYCAppRecomViewDelegate>

@property (nonatomic, weak)SYCAppMoreBaseItem *baseItem;

@property (nonatomic, weak)SYCImageDisplayView *imageDisView;

@property (nonatomic, weak)SYCOpenBarView *openBarView;

@property (nonatomic, weak)SYCAppIntroduceView *introduceView;

@property (nonatomic, weak)SYCAppRecomView *reccomView;

@property (nonatomic, weak)SYCInfoView *infoView;

@property (nonatomic, weak)UIScrollView *rootView;
@end

@implementation SYCAppBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setUpAllChildView];
    
    [SYCDataRequestTool dataRequestWithDetailAppBaseUrl:self.item.detailUrl success:^(SYCAppMoreBaseItem *baseItem) {
        self.baseItem = baseItem;
//        NSLog(@"%s,%@",__func__,[NSThread currentThread]);
        [self setUpAllChildViewOfScrollView];
        [self setUpAllChildViewFrame];
    } failure:^(NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }
    }];
}

#pragma mark - 添加button和scrollView
- (void)setUpAllChildView{

//    NSLog(@"%s,%@",__func__,[NSThread currentThread]);
    UIScrollView *rootView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    _rootView = rootView;
    rootView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:rootView];

    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"detail_back_normal"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"detail_back_press"] forState:UIControlStateHighlighted];
    backBtn.frame = CGRectMake(15, 35, 36, 36);
    [backBtn addTarget:self action:@selector(backToPre) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];

    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(viewW - 47, 35, 36, 36);
    [shareBtn setImage:[UIImage imageNamed:@"detail_share_normal"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"detail_share_press"] forState:UIControlStateHighlighted];
    [shareBtn addTarget:self action:@selector(shareToOther) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
}
#pragma mark - 跳转上一个控制器
- (void)backToPre{
//    NSLog(@"%s,%@",__func__,[NSThread currentThread]);
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"%s,%@",__func__,[NSThread currentThread]);
    }];
}
#pragma mark - 分享更多
- (void)shareToOther{
    NSLog(@"%s",__func__);
}
#pragma mark - 给scrollView添加子控件
- (void)setUpAllChildViewOfScrollView{
//    NSLog(@"%s,%@",__func__,[NSThread currentThread]);
    SYCImageDisplayView *imageDisView = [[SYCImageDisplayView alloc] initWithFrame:CGRectMake(0, 20, viewW, 300)];
    _imageDisView = imageDisView;
    imageDisView.images = _baseItem.snapshots;
    [_rootView addSubview:imageDisView];
    
    SYCOpenBarView *openBar = [[SYCOpenBarView alloc] init];
    openBar.baseItem = _baseItem;
    _openBarView = openBar;
    [_rootView addSubview:openBar];
    
    SYCAppIntroduceView *descView = [[SYCAppIntroduceView alloc] init];
    descView.baseItem = _baseItem;
    descView.delegate = self;
    _introduceView = descView;
    [_rootView addSubview:descView];
    
    SYCAppRecomView *recomView = [[SYCAppRecomView alloc] init];
    recomView.baseItem = _baseItem;
    recomView.delegate = self;
    _reccomView = recomView;
    [self.rootView addSubview:recomView];
    
    SYCInfoView *infoView = [[SYCInfoView alloc] init];
    infoView.baseItem = _baseItem;
    _infoView = infoView;
    [self.rootView addSubview:infoView];
    
}
#pragma mark - 设置scrollView里所有子控件的frame
- (void)setUpAllChildViewFrame{
//    NSLog(@"%s,%@",__func__,[NSThread currentThread]);
    //图片滚动视图
    CGFloat imaX = 0;
    CGFloat imaY = 20;
    CGFloat imaW = viewW;
    CGFloat imaH = 300;
    _imageDisView.frame = CGRectMake(imaX, imaY, imaW, imaH);
    
    //信息视图
    CGFloat barX = 0;
    CGFloat barY = imaH + 20;
    CGFloat barW = viewW;
    CGFloat barH = 100;
    _openBarView.frame = CGRectMake(barX, barY, barW, barH);
    
    //应用简介
    CGFloat descX = 0;
    CGFloat descY = CGRectGetMaxY(_openBarView.frame);
    CGFloat descW = viewW;
    CGFloat descH = 130;
    if (_introduceView.transView.selected) {
        descH = [_introduceView heightForIntroduceView];
    }
    _introduceView.frame = CGRectMake(descX, descY, descW, descH);
    
    //推荐应用
    CGFloat recomX = 0;
    CGFloat recomY = CGRectGetMaxY(_introduceView.frame);
    CGFloat recomW = viewW;
    CGFloat recomH = 150;
    _reccomView.frame = CGRectMake(recomX, recomY, recomW, recomH);
    
    //详细信息
    CGFloat infoX = 0;
    CGFloat infoY = CGRectGetMaxY(_reccomView.frame);
    CGFloat infoW = viewW;
    CGFloat infoH = [_infoView heightForInformationView];
    NSLog(@"%f",infoH);
    _infoView.frame = CGRectMake(infoX, infoY, infoW, infoH);
    CGFloat contentH = CGRectGetMaxY(_infoView.frame);
    _rootView.contentSize = CGSizeMake(viewW, contentH);
}
#pragma mark - 点击展开按钮的代理
- (void)reloadDataFrame{
    [self setUpAllChildViewFrame];
}

- (void)recomViewJustToBaseViewWithItem:(SYCAppBaseItem *)item{
    SYCAppBaseViewController *baseVc = [[SYCAppBaseViewController alloc] init];
    baseVc.item = item;
    [self presentViewController:baseVc animated:YES completion:^{
//        NSLog(@"%s",__func__);
    }];
}
- (void)dealloc{
    NSLog(@"%s,%@",__func__,[NSThread currentThread]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
