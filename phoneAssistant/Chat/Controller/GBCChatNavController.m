//
//  GBCChatNavController.m
//  phoneAssistant
//
//  Created by Denny_cheng on 15/9/1.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import "GBCChatNavController.h"
#import "GBCChatTblController.h"

@interface GBCChatNavController ()

@end

@implementation GBCChatNavController

- (instancetype)init
{
    GBCChatTblController *chat=[[GBCChatTblController alloc] init];
    return [super initWithRootViewController:chat];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarItem.title=@"聊吧";
    //self.navigationItem.title=@"聊吧";
    
    [self setTabBar:@"homepage_talk" imgSelected:@"homepage_talk_sel"];
    
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
