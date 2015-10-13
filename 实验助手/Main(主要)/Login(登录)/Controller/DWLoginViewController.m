//
//  SXQLoginViewController.m
//  实验助手
//
//  Created by sxq on 15/10/8.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "LoginTool.h"
#import "DWLoginViewController.h"
#import "MBProgressHUD+MJ.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface DWLoginViewController ()
@property (nonatomic,weak) IBOutlet UITextField  *userNameField;
@property (nonatomic,weak) IBOutlet UITextField  *password;
@property (nonatomic,weak) IBOutlet UIButton *remenberBtn;
@property (nonatomic,weak) IBOutlet UIButton *forgetBtn;
@property (nonatomic,weak) IBOutlet UIButton *logBtn;
@property (nonatomic,weak) IBOutlet UIButton *signupBtn;
@end

@implementation DWLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bindingTextField];
}
- (void)bindingTextField
{
    RACSignal *validNameSignal = [[_userNameField.rac_textSignal map:^id(NSString *nameText) {
        return @(nameText.length);
    }] map:^id(NSNumber *nameLength) {
        return @([nameLength integerValue] > 2);
    }];
    
    RACSignal *validPassSignal = [[_password.rac_textSignal map:^id(NSString *passText) {
        return @(passText.length);
    }] map:^id(NSNumber *passLength) {
        return @([passLength integerValue] > 2);
    }];
    
    [[RACSignal combineLatest:@[validNameSignal,validPassSignal] reduce:^id(NSNumber *userNameValid,NSNumber *passValid){
        return @([userNameValid boolValue] && [passValid boolValue]);
    }] subscribeNext:^(NSNumber *loginActive) {
        _logBtn.enabled = [loginActive boolValue];
    }];
    [[[[_logBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     doNext:^(id x) {
        _logBtn.enabled = NO;
    }] flattenMap:^RACStream *(id value) {
        return [self loginSignal];
    }] subscribeNext:^(NSNumber *logined) {
        _logBtn.enabled = YES;
        BOOL success = [logined boolValue];
        if (success) {
            //切换根控制器
            UIStoryboard *storedBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *rootVC = [storedBoard instantiateInitialViewController];
            self.view.window.rootViewController = rootVC;
        }else
        {
            [MBProgressHUD showError:@"用户名或密码错误"];
        }
    }];
}
- (RACSignal *)loginSignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [LoginTool loginWithUserName:_userNameField.text password:_password.text completion:^(BOOL success) {
            [subscriber sendNext:@(success)];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
    return nil;
}

@end
