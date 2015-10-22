//
//  SXQLoginController.m
//  实验助手
//
//  Created by sxq on 15/10/22.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "SXQLoginController.h"
#import "SXQLoginViewModel.h"
#import "SXQLoginContainer.h"
#import "SXQLoginViewModelServiceImpl.h"
#import "MBProgressHUD+MJ.h"
@interface SXQLoginController ()
@property (weak, nonatomic) IBOutlet SXQLoginContainer *loginContainer;
@property (nonatomic,strong) SXQLoginViewModel *viewModel;
@property (nonatomic,strong) SXQLoginViewModelServiceImpl *service;
@end

@implementation SXQLoginController
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        _service = [SXQLoginViewModelServiceImpl new];
        _viewModel = [[SXQLoginViewModel alloc] initWithService:_service];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginContainer.viewModel = _viewModel;
    @weakify(self)
    [[_viewModel.loginCmd.executionSignals switchToLatest]
    subscribeNext:^(NSNumber *isLoginSuccess) {
        @strongify(self)
        if ([isLoginSuccess boolValue]) {
            //切换根控制器
            self.view.window.rootViewController = [self mainRootViewController];
        }else
        {
            [MBProgressHUD showError:@"用户名或密码错误"];
        }
    }];
}
- (UIViewController *)mainRootViewController
{
    return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
}



@end
