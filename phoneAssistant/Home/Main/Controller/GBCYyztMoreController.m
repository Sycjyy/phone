//
//  GBCYyztMoreController.m
//  phoneAssistant
//
//  Created by Denny_cheng on 15/9/30.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import "GBCYyztMoreController.h"
#import "GBCYyztModel.h"
#import "GBCHeaderTblController.h"

@interface GBCYyztMoreController ()
@property(nonatomic,weak) UIView *showView;
@property(nonatomic,assign) CGFloat scrollSumH;

@end

@implementation GBCYyztMoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBackBtn];
    [self showMore];
}
- (void)setBackBtn
{
    UIButton *leftBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    [leftBtn sizeToFit];
    [leftBtn addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"web_pre_nor"] forState:(UIControlStateNormal)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"web_pre_pre"] forState:(UIControlStateHighlighted)];
    
    UIBarButtonItem *left=[[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem=left;
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)showMore
{
    CGFloat pading=5;
    CGFloat titleH=20;
    CGFloat summaryH=12;

    CGSize size=[UIScreen mainScreen].bounds.size;
    UIScrollView *scroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height-49)];
    scroll.backgroundColor=[UIColor whiteColor];
    scroll.showsVerticalScrollIndicator=NO;
    
    for (NSUInteger i=0; i<self.arrYyzt.count; i++) {
            GBCYyztModel *yyztModel=self.arrYyzt[i];
        
//        UIView *showView=[[UIView alloc] init];
//        self.view addSubview:
        
        UIButton *imageBtn=[[UIButton alloc] init];
        CGFloat imageBtnX=pading;
        CGFloat imageBtnH=(size.height-titleH-summaryH)/2;
        CGFloat imageBtnW=size.width-2*pading;
        CGFloat imageBtnY=(imageBtnH+titleH+summaryH)*i;
        imageBtn.frame=CGRectMake(imageBtnX, imageBtnY, imageBtnW, imageBtnH);
        imageBtn.tag=i;
        [imageBtn addTarget:self action:@selector(showDetail:) forControlEvents:(UIControlEventTouchUpInside)];
        
        NSURL *url=[NSURL URLWithString:yyztModel.icon];
        NSData *urlData=[NSData dataWithContentsOfURL:url];
        [imageBtn setBackgroundImage:[UIImage imageWithData:urlData] forState:(UIControlStateNormal)];
        [imageBtn setBackgroundImage:[UIImage imageWithData:urlData] forState:(UIControlStateHighlighted)];
        [scroll addSubview:imageBtn];
        
        UILabel *title=[[UILabel alloc] init];
        CGFloat titleX=imageBtnX;
        CGFloat titleY=CGRectGetMaxY(imageBtn.frame);
        CGFloat titleW=imageBtnW;
        title.frame=CGRectMake(titleX, titleY, titleW, titleH);
        title.text=yyztModel.name;
        [title setFont:[UIFont systemFontOfSize:17]];
        [scroll addSubview:title];
        
        UILabel *summary=[[UILabel alloc]  init];
        CGFloat summaryX=imageBtnX;
        CGFloat summaryY=CGRectGetMaxY(title.frame);
        CGFloat summaryW=imageBtnW;
        summary.frame=CGRectMake(summaryX, summaryY, summaryW, summaryH);
        summary.text=yyztModel.summary;
        [summary setFont:[UIFont systemFontOfSize:10]];
        [scroll addSubview:summary];
        if (i==self.arrYyzt.count-1) {
            self.scrollSumH=CGRectGetMaxY(summary.frame)-40;
        }
    }
    scroll.contentSize=CGSizeMake(size.width, self.scrollSumH);
    [self.view addSubview:scroll];
}
- (void)showDetail:(UIButton *)btn
{
    GBCHeaderTblController *header=[[GBCHeaderTblController alloc] init];
    GBCYyztModel *yyzt=[[GBCYyztModel alloc] init];
    yyzt=self.arrYyzt[btn.tag];
    header.title=yyzt.name;
    header.TargetUrl=yyzt.url;
    [self.navigationController pushViewController:header animated:YES];
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
