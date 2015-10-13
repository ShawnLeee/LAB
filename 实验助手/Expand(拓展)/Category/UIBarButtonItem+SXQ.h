//
//  UIBarButtonItem+SXQ.h
//  实验助手
//
//  Created by sxq on 15/9/15.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (SXQ)
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action;
+ (UIBarButtonItem *)itemWithImage:(NSString *)imageName target:(id)target action:(SEL)action;
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title action:(void (^)())action;
@end
