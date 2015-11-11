//
//  GBCBaseNavController.m
//  phoneAssistant
//
//  Created by Denny_cheng on 15/9/1.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import "GBCBaseNavController.h"

@interface GBCBaseNavController ()

@end

@implementation GBCBaseNavController


//tabBar显示图片和设置字体颜色的方法
- (void)setTabBar:(NSString *)imgNormal imgSelected:(NSString *)imgSelected
{
    //设置字体颜色217 190 124//R:215 G:186 B:121
    NSDictionary *dictSelected=@{NSForegroundColorAttributeName:[UIColor colorWithRed:215/255.0 green:186/255.0 blue:121/255.0 alpha:1]};
    [self.tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
    
    
    NSDictionary *dictNormal=@{NSForegroundColorAttributeName:[UIColor blackColor]};
    [self.tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    
    self.tabBarItem.image=[UIImage imageNamed:imgNormal];
    UIImage *img=[UIImage imageNamed:imgSelected];
    img=[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem.selectedImage=img;
    
    
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.barTintColor=[UIColor blackColor];
    [self.navigationBar setBarStyle:UIBarStyleBlack];
    
    
    
    
    // Do any additional setup after loading the view.
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
