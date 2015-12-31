//
//  SYCTabBarController.m
//  91助手
//
//  Created by sycjyy on 15/11/26.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCTabBarController.h"
#import "SYCBaseNavigationController.h"

#import "SYCHomeViewController.h"
#import "SYCCharViewController.h"
#import "SYCReviewViewController.h"
#import "SYCSearchViewController.h"
#import "SYCTabBar.h"

#import "UIImage+Image.h"

@interface SYCTabBarController ()<SYCTabBarDelegate>

@property (nonatomic, weak) SYCHomeViewController *home;
@property (nonatomic, weak) SYCCharViewController *chat;
@property (nonatomic, weak) SYCReviewViewController *review;
@property (nonatomic, weak) SYCSearchViewController *search;

@property (nonatomic, strong) NSMutableArray *items;
@end

@implementation SYCTabBarController

- (NSMutableArray *)items{
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpAllChildViewController];
    
    [self setUpTabBar];
    
    
}
#pragma mark - 设置自定义的tabBar
- (void)setUpTabBar{
    SYCTabBar *tabBar = [[SYCTabBar alloc] initWithFrame:self.tabBar.bounds];
    tabBar.items = self.items;
    tabBar.delegate = self;
    [self.tabBar addSubview:tabBar];
}
#pragma mark - tabBar代理
- (void)tabBar:(SYCTabBar *)tabBar didClickButton:(NSInteger)index{
    self.selectedIndex = index;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            [tabBarButton removeFromSuperview];
        }
    }
}
#pragma mark - 添加所有的子控制器
- (void)setUpAllChildViewController{
    //home
    SYCHomeViewController *home = [[SYCHomeViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self setUpOneChildViewController:home image:[UIImage imageNamed:@"homepage_home"] selectedImage:[UIImage imageWithOriginalName:@"homepage_home_sel"] title:@"首页"];
    _home = home;
    
    //chat
    SYCCharViewController *chat = [[SYCCharViewController alloc] init];
    [self setUpOneChildViewController:chat image:[UIImage imageNamed:@"homepage_talk"] selectedImage:[UIImage imageWithOriginalName:@"homepage_talk_sel"] title:@"聊吧"];
    _chat = chat;
    
    //review
    SYCReviewViewController *review = [[SYCReviewViewController alloc] init];
    [self setUpOneChildViewController:review image:[UIImage imageNamed:@"homepage_cate"] selectedImage:[UIImage imageWithOriginalName:@"homepage_cate_sel"] title:@"分类"];
    _review = review;
    
    //search
    SYCSearchViewController *search = [[SYCSearchViewController alloc] init];
    [self setUpOneChildViewController:search image:[UIImage imageNamed:@"homepage_seach"] selectedImage:[UIImage imageWithOriginalName:@"homepage_seach_sel"] title:@"搜索"];
    _search = search;
    
}

#pragma mark - 添加一个子控制器
- (void)setUpOneChildViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title{
    vc.title = title;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage;
    [self.items addObject:vc.tabBarItem];

    
    SYCBaseNavigationController *nav = [[SYCBaseNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
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
