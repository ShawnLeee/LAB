//
//  SXQNavgationController.m
//  实验助手
//
//  Created by SXQ on 15/8/30.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//

#import "SXQNavgationController.h"

@interface SXQNavgationController ()

@end

@implementation SXQNavgationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
+ (void)initialize
{
    UINavigationBar *navbarAppearance = [UINavigationBar appearance];
    navbarAppearance.barTintColor = [UIColor colorWithRed:0.29 green:0.47 blue:0.78 alpha:1.0];
    navbarAppearance.tintColor = [UIColor colorWithRed:0.24 green:0.24 blue:0.26 alpha:1.0];
    navbarAppearance.translucent = NO;
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.hidesBottomBarWhenPushed = YES;
//    viewController.view.window.backgroundColor = [UIColor whiteColor];
    [super pushViewController:viewController animated:YES];
}
- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated
{
    [super setViewControllers:viewControllers animated:animated];
}
@end
