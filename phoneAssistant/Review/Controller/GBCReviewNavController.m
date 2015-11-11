//
//  GBCReviewNavController.m
//  phoneAssistant
//
//  Created by Denny_cheng on 15/9/1.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import "GBCReviewNavController.h"
#import "GBCReviewTblController.h"

@interface GBCReviewNavController ()

@end

@implementation GBCReviewNavController

- (instancetype)init
{
    GBCReviewTblController *review=[[GBCReviewTblController alloc] init];
    return [super initWithRootViewController:review];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarItem.title=@"评测";
    
    [self setTabBar:@"homepage_spe" imgSelected:@"homepage_spe_sel"];
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
