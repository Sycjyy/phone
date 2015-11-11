//
//  GBCHomeNavController.m
//  phoneAssistant
//
//  Created by Denny_cheng on 15/9/1.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import "GBCHomeNavController.h"
#import "GBCHomeTblController.h"

@interface GBCHomeNavController ()

@end

@implementation GBCHomeNavController

- (instancetype)init
{
    GBCHomeTblController *home=[[GBCHomeTblController alloc] init];
    return [super initWithRootViewController:home];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarItem.title=@"首页";
    
    [self.navigationBar setBarStyle:(UIBarStyleBlack)];
    
    [self setTabBar:@"homepage_home" imgSelected:@"homepage_home_sel"];
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
