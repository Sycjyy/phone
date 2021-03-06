//
//  AppDelegate.m
//  phoneAssistant
//
//  Created by Denny_cheng on 15/9/1.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import "AppDelegate.h"
#import "GBCTabBarController.h"
#import "GBCNewFeature.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *oldVersion=[defaults stringForKey:@"version"];
    NSDictionary *dict=[NSBundle mainBundle].infoDictionary;
    NSString *currentVersion=dict[@"CFBundleVersion"];
    
//    GBCNewFeature *feature=[[GBCNewFeature alloc] init];
//    self.window.rootViewController=feature;
//    [self.window makeKeyAndVisible];
//    return YES;
    
    if (oldVersion==nil||![oldVersion isEqualToString:currentVersion]) {
        //如果是第一次安装或者现在的两个版本不一样，需要显示新特性
        GBCNewFeature *feature=[[GBCNewFeature alloc] init];
        self.window.rootViewController=feature;
        //保存现在的版本
        [defaults setObject:currentVersion forKey:@"version"];
    }else{
        GBCTabBarController *tabBarVc=[[GBCTabBarController alloc] init];
        self.window.rootViewController=tabBarVc;
    }
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
