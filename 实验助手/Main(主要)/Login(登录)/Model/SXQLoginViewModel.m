//
//  SXQLoginViewModel.m
//  实验助手
//
//  Created by sxq on 15/10/22.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQLoginViewModel.h"
@interface SXQLoginViewModel ()
@property (nonatomic,strong) id<SXQLoginViewModelService> service;
@end
@implementation SXQLoginViewModel
- (instancetype)initWithService:(id<SXQLoginViewModelService>)service
{
    if (self = [super init]) {
        _service = service;
        [self p_setupSelf];
    }
    return self;
}
- (instancetype)init
{
    if (self = [super init]) {
        [self p_setupSelf];
    }
    return self;
}
- (void)p_setupSelf
{
    RACSignal *validLogin = [RACSignal
                             combineLatest:@[RACObserve(self, username),RACObserve(self, password)]
                             reduce:^id(NSString *username,NSString *password){
                                 return @(username.length > 0 && password.length > 0);
                             }];
    _loginCmd = [[RACCommand alloc] initWithEnabled:validLogin signalBlock:^RACSignal *(id input) {
        return [self loginSignal];
    }];
}
- (RACSignal *)loginSignal
{
    return [[self.service getService] loginSignalWithUsername:self.username password:self.password];
}
@end
