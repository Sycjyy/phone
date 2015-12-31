//
//  SYCBaseNavigationController.m
//  91助手
//
//  Created by sycjyy on 15/11/26.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//

#import "SYCBaseNavigationController.h"

@interface SYCBaseNavigationController ()<UINavigationControllerDelegate>

@property (nonatomic, strong)id popDelegate;
@end

@implementation SYCBaseNavigationController

+ (void)initialize{
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    
    NSMutableDictionary *titleDic = [NSMutableDictionary dictionary];
    titleDic[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:titleDic forState:UIControlStateNormal];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bar_background_2"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setBarStyle:UIBarStyleBlack];
    _popDelegate = self.interactivePopGestureRecognizer.delegate;
    
    self.interactivePopGestureRecognizer.delegate = nil;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //添加左侧的返回按钮
    if (self.viewControllers.count != 0) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"bar_back_selected"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"bar_back"] forState:UIControlStateHighlighted];
        [btn sizeToFit];
        [btn addTarget:self action:@selector(backToPre) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
        viewController.navigationItem.leftBarButtonItem =leftItem;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)backToPre{
    [self popViewControllerAnimated:YES];
}

#pragma mark - 导航控制器的代理方法 导航控制器跳转完成的时候
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{//当自定义tabBar时手势左划时出现卡死状态
    if (viewController == self.viewControllers[0]) {
        //
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
    }else{
        
        self.interactivePopGestureRecognizer.delegate = nil;
    }

}
#pragma mark - 设置状态栏内容类型为亮色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
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
