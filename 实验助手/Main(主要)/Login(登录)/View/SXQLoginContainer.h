//
//  SXQLoginContainer.h
//  实验助手
//
//  Created by sxq on 15/10/22.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class SXQLoginViewModel;
#import <UIKit/UIKit.h>

@interface SXQLoginContainer : UIView
- (instancetype)initWithLoginViewModel:(SXQLoginViewModel *)viewModel;
@property (nonatomic,strong) SXQLoginViewModel *viewModel;
@end
