//
//  UIBarButtonItem+SXQ.m
//  实验助手
//
//  Created by sxq on 15/9/15.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "UIBarButtonItem+SXQ.h"

@implementation UIBarButtonItem (SXQ)
+ (UIBarButtonItem *)itemWithImage:(NSString *)imageName target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 35, 35);
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    button.imageView.contentMode = UIViewContentModeCenter;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title action:(void (^)())action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 60, 30);
    [[button rac_signalForControlEvents:UIControlEventTouchDown]
        subscribeNext:^(id x) {
            action();
    }];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
@end
