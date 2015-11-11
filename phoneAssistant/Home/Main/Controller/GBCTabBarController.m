//
//  GBCTabBarController.m
//  phoneAssistant
//
//  Created by Denny_cheng on 15/9/1.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import "GBCTabBarController.h"
#import "GBCHomeNavController.h"
#import "GBCChatNavController.h"
#import "GBCReviewNavController.h"
#import "GBCSearchNavController.h"

@interface GBCTabBarController ()

@end

@implementation GBCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    GBCHomeNavController *home=[[GBCHomeNavController alloc] init];
    GBCChatNavController *chat=[[GBCChatNavController alloc] init];
    GBCReviewNavController *review=[[GBCReviewNavController alloc] init];
    GBCSearchNavController *search=[[GBCSearchNavController alloc] init];
    
    self.viewControllers=@[home,chat,review,search];
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
