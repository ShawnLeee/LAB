//
//  SXQLoginViewModel.h
//  实验助手
//
//  Created by sxq on 15/10/22.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class RACCommand;
#import "SXQLoginViewModelService.h"
#import <Foundation/Foundation.h>

@interface SXQLoginViewModel : NSObject
@property (nonatomic,copy) NSString *username;
@property (nonatomic,copy) NSString *password;
@property (nonatomic,strong) RACCommand *forgetCmd;
@property (nonatomic,strong) RACCommand *rememberCmd;
@property (nonatomic,strong) RACCommand *loginCmd;
@property (nonatomic,strong) RACCommand *signupCmd;

- (instancetype)initWithService:(id<SXQLoginViewModelService>)service;
@end
