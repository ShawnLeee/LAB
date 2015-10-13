//
//  SXQLoginViewController.m
//  实验助手
//
//  Created by sxq on 15/9/11.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
#import "SXQLoginViewController.h"
#import "SXQLoginField.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SXQVenderLoginTool.h"
#import "SXQVenderLogin.h"
#import "LoginTool.h"
@interface SXQLoginViewController () <SXQVenderLoginDelegate>
@property(weak, nonatomic) IBOutlet SXQVenderLogin *loginView;
@property(weak, nonatomic) IBOutlet UIButton *loginBtn;
@property(weak, nonatomic) IBOutlet SXQLoginField *loginField;
@property (weak, nonatomic) IBOutlet UIButton *forgetPassBtn;
@property (weak, nonatomic) IBOutlet UIButton *smsLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *signUpBtn;

@end

@implementation SXQLoginViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setup];
}
- (void)setup {
  _loginView.delegate = self;
  self.view.backgroundColor = [UIColor colorWithRed:239.0 / 255.0
                                              green:239.0 / 255.0
                                               blue:244.0 / 255.0
                                              alpha:1.0];
  [_loginBtn setBackgroundColor:[UIColor colorWithRed:76 / 255.0
                                                green:217 / 255.0
                                                 blue:99 / 255.0
                                                alpha:1.0]];
  _loginBtn.layer.cornerRadius = 4;
  [self setupLogin];
    [self bindingSignUpBtn];
}
- (void)setupLogin {
  RACSignal *userNametextSignal = _loginField.userField.rac_textSignal;
  RACSignal *passWdtextSignal = _loginField.passWordField.rac_textSignal;

  RACSignal *validNameSignal = [[userNametextSignal map:^id(NSString *text) {
    return @(text.length);
  }] map:^id(NSNumber *length) {
    return @([length integerValue] > 6);
  }];

  RACSignal *validPassWdSignal = [[passWdtextSignal map:^id(NSString *text) {
    return @(text.length);
  }] map:^id(NSNumber *length) {
    return @([length integerValue] > 6);
  }];

  RACSignal *loginActiveSignal = [RACSignal
      combineLatest:@[ validNameSignal, validPassWdSignal ]
             reduce:^id(NSNumber *userNameValid, NSNumber *passWdValid) {
               return @([userNameValid integerValue] &&
                        [passWdValid integerValue]);
             }];
  [loginActiveSignal subscribeNext:^(NSNumber *signUpActive) {
    _loginBtn.enabled = [signUpActive boolValue];
  }];

  [[[[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
      doNext:^(id x) {
        _loginBtn.enabled = NO;
      }] flattenMap:^RACStream *(id value) {
    return [self signInsignal];
  }] subscribeNext:^(NSNumber *signedId) {
    _loginBtn.enabled = YES;
    BOOL success = [signedId boolValue];
    if (success) {
      [self p_loginSuccess:success];
    } else {
      NSLog(@"Try again");
    }
  }];
}
- (void)bindingSignUpBtn
{
    [[[[_signUpBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
        doNext:^(id x) {
            
        }] flattenMap:^RACStream *(id value) {
            return [self signupSignal];
        }] subscribeNext:^(id x) {
            NSLog(@"%@",x);
        }];
}
- (void)loginWithUserName:(NSString *)userName
                 password:(NSString *)password
                 complete:(void (^)(BOOL success))completionBlk {
  BOOL result = [userName isEqualToString:@"username"] &&
                [password isEqualToString:@"password"];
  completionBlk(result);
}
- (RACSignal *)signInsignal {
  return
      [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self loginWithUserName:_loginField.userField.text
                       password:_loginField.passWordField.text
                       complete:^(BOOL success) {
                         [subscriber sendNext:@(success)];
                         [subscriber sendCompleted];
                       }];
        return nil;
      }];
}
- (RACSignal *)signupSignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        SignUpParam *param = [SignUpParam paramWithNickName:@"123" passwd:@"123"];
        [LoginTool signUpWithParam:nil completion:^(BOOL success) {
            [subscriber sendNext:@(success)];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}
- (void)doSomeThing
{
    
}
- (void)viewDidLayoutSubviews {
  [_loginView updateMyConstraints];
}

- (void)venderLogin:(SXQVenderLogin *)view
    clickedButtonAtIndex:(NSUInteger)index {
  switch (index) {
  case 0:
      { [SXQVenderLoginTool venderLoginWithLoginType:VenderLoginTypeWeibo completion:^(BOOL success) {
          [self p_loginSuccess:success];
          }];
          break;
      }
  case 1:
          [SXQVenderLoginTool venderLoginWithLoginType:VenderLoginTypeWeChat completion:^(BOOL success) {
              
          }];
    break;
  case 2:
          [SXQVenderLoginTool venderLoginWithLoginType:VenderLoginTypeQQ completion:^(BOOL success) {
              
          }];
    break;
  }
}
- (void)p_loginSuccess:(BOOL)success
{
    if (success) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
