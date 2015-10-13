//
//  SXQVenderLogin.h
//  实验助手
//
//  Created by sxq on 15/9/10.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
@class SXQVenderLogin;
#import <UIKit/UIKit.h>
@protocol SXQVenderLoginDelegate <NSObject>
@optional
- (void)venderLogin:(SXQVenderLogin *)view clickedButtonAtIndex:(NSUInteger)index;

@end

@interface SXQVenderLogin : UIView
@property (strong, nonatomic) IBOutlet UIView *view;
@property (nonatomic,weak) id<SXQVenderLoginDelegate> delegate;
- (void)updateMyConstraints;
@end
