//
//  SXQMeViewController.m
//  实验助手
//
//  Created by sxq on 15/9/10.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
#import "SXQLoginViewController.h"
#import "SXQMeViewController.h"
#import "SXQVenderLogin.h"
@interface SXQMeViewController ()

@end

@implementation SXQMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)login:(UIButton *)sender {
    UIViewController *vc = [SXQLoginViewController new];
    [self.navigationController pushViewController:vc animated:YES];
//    vc.hidesBottomBarWhenPushed = YES;
//    CATransition *transition = [CATransition animation];
//    transition.duration = 0.5;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    transition.type = kCATransitionFromBottom;
//    [self.navigationController.view.layer addAnimation:transition forKey:nil];
//    [self.navigationController pushViewController:vc animated:NO];
}

@end
