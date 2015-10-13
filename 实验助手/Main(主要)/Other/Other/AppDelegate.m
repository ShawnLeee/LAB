//
//  AppDelegate.m
//  实验助手
//
//  Created by SXQ on 15/8/30.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
#import "DWLoginViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <Parse/Parse.h>
#import "WeiboSDK.h"
#import "WXApi.h"
#import "AppDelegate.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    [self.window makeKeyAndVisible];
//    DWLoginViewController *loginvc = [DWLoginViewController new];
//    self.window.rootViewController = loginvc;
    [self initializeSDK:launchOptions];
    return YES;
}

- (void)initializeSDK:(NSDictionary *)launchOptions
{
    [ShareSDK registerApp:@"a49a0b112fc0"];
    [Parse setApplicationId:@"CvNR2CTp1WFQV0JBZbAwJxlLJN7fQ9wHlN60izKI" clientKey:@"RRQMOVRAr5iEgToCkLEdMSM9VOn5ouoPMdGnpvbm"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    [self initializeVenderPlatform];
}
- (void)initializeVenderPlatform
{
    [ShareSDK connectSinaWeiboWithAppKey:@"1025145242" appSecret:@"2e264190d37e5d99382a4f30de539b4f" redirectUri:@"http://www.vocabulary.com/"];
    [ShareSDK connectWeChatWithAppId:@"wx4868b35061f87885"
                           appSecret:@"64020361b8ec4c99936c0e3999a9f249"
                           wechatCls:[WXApi class]];
    [ShareSDK connectSMS];
    //连接邮件
    [ShareSDK connectMail];
    
    //连接打印
    [ShareSDK connectAirPrint];
    
    //连接拷贝
    [ShareSDK connectCopy];
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
