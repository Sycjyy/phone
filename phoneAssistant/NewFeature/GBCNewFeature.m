//
//  GBCNewFeature.m
//  phoneAssistant
//
//  Created by Denny_cheng on 15/10/3.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//
#define SIZE [UIScreen mainScreen].bounds.size
#import "GBCNewFeature.h"
#import "GBCTabBarController.h"

@interface GBCNewFeature ()<UIScrollViewDelegate>
@property(nonatomic,weak) UIPageControl *page;

@end

@implementation GBCNewFeature

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scroll=[[UIScrollView alloc] initWithFrame:self.view.frame];
    scroll.delegate=self;
    scroll.pagingEnabled=YES;
    scroll.showsHorizontalScrollIndicator=NO;
    scroll.bounces=NO;
    
    [self.view addSubview:scroll];
    scroll.contentSize=CGSizeMake(SIZE.width*3,  SIZE.height);
    CGFloat imgViewW=SIZE.width;
    CGFloat imgViewH=SIZE.height;

    for (NSUInteger i=1; i<=3; i++) {
        CGFloat imgViewX=(i-1)*SIZE.width;
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(imgViewX, 0, imgViewW, imgViewH)];
        NSString *file=[NSString stringWithFormat:@"%zd.jpg",i];
        imgView.image=[UIImage imageNamed:file];
        [scroll addSubview:imgView];
        if (i==3) {
            [self createEnterBtn:imgView];
        }
    }
}
- (void)createEnterBtn:(UIImageView *)imgView
{
    imgView.userInteractionEnabled=YES;
    UIButton *enterBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [imgView addSubview:enterBtn];
    CGFloat btnCenterX=self.view.bounds.size.width*0.5;
    CGFloat btnCenterY=self.view.bounds.size.height-50;
    enterBtn.frame=CGRectMake(0, 0, 120, 30);
    enterBtn.center=CGPointMake(btnCenterX, btnCenterY);
    [enterBtn setTitle:@"体验新生活" forState:UIControlStateNormal];
    [enterBtn setTitle:@"体验新生活" forState:UIControlStateHighlighted];
    [enterBtn setBackgroundColor:[UIColor redColor]];
    [enterBtn addTarget:self action:@selector(clickEnterBtn) forControlEvents:UIControlEventTouchUpInside];
    
    UIPageControl *page=[[UIPageControl alloc] init];
    self.page=page;
    CGRect rect=enterBtn.frame;
    rect.origin.y-=40;
    page.frame=rect;
    page.currentPageIndicatorTintColor=[UIColor redColor];
    page.pageIndicatorTintColor=[UIColor grayColor];
    page.numberOfPages=3;
    [self.view addSubview:page];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offPoint=scrollView.contentOffset;
    NSUInteger pageNum=(offPoint.x+=SIZE.width*0.5)/SIZE.width;
    self.page.currentPage=pageNum;
}
                                                                            
- (void)clickEnterBtn
{
    GBCTabBarController *tabVc=[[GBCTabBarController alloc] init];
    UIWindow *keyWindow=[UIApplication sharedApplication].keyWindow;
    keyWindow.rootViewController=tabVc;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
