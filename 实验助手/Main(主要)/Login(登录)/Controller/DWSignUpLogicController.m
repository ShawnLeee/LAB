// //  DWSignUpLogicController.m
//  实验助手
//
//  Created by sxq on 15/10/20.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "DWSignUpLogicController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "NSString+Check.h"
#import "MBProgressHUD+MJ.h"
#import "LoginTool.h"
@interface DWSignUpLogicController ()
@property (nonatomic,strong) SignUpParam *signupParam;
@end

@implementation DWSignUpLogicController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self bindingMustFill];
}
- (void)bindingMustFill
{
    RACSignal *passwordValidSignal = [self.password.rac_textSignal
                                      map:^id(NSString *text) {
                                          return @(text.length > 2);
                                      }];
    RAC(self.password,backgroundColor) = [passwordValidSignal map:^id(NSNumber *passValid) {
                                            return [passValid boolValue] ? [UIColor clearColor] : [UIColor lightGrayColor];
                                        }];
    RACSignal *repasswordValidSignal = [self.repassword.rac_textSignal
                                        map:^id(NSString *text) {
                                            return @(text.length > 2);
                                        }];
    
    RACSignal *passValid = [RACSignal combineLatest:@[passwordValidSignal,repasswordValidSignal ]
                                             reduce:^id(NSNumber *passValid,NSNumber *repassValid){
                                                 return @([passValid boolValue] && [repassValid boolValue]);
                            }];
    
    RACSignal *passwordMatchSignal = [RACSignal combineLatest:@[self.password.rac_textSignal,self.repassword.rac_textSignal]
                                                      reduce:^id(NSString *pass,NSString *repass){
                                                          return @([pass isEqualToString:repass]);
                                                      }];
    
    RACSignal *emailValidSignal = [self.email.rac_textSignal
                                   map:^id(NSString *email) {
                                       return @([email dg_isValidMailbox]);
                                   }];
    
    RACSignal *userNameValidSignal = [self.userName.rac_textSignal map:^id(NSString *text) {
        return @(text.length > 2);
    }];
    RACSignal *compelValidSignal =[RACSignal combineLatest:@[passwordMatchSignal,emailValidSignal,userNameValidSignal,passValid]
                                                     reduce:^id(NSNumber *passMatch,NSNumber *emailVaild,NSNumber *userNameValid,NSNumber *passValid){
                                                         return @([passMatch boolValue] && [emailVaild boolValue] &&[userNameValid boolValue] && [passValid boolValue]);
                                    }];
    
    [[compelValidSignal
        filter:^BOOL(NSNumber *valid) {
            return [valid boolValue];
        }] subscribeNext:^(id x) {
            _signupParam = [SignUpParam paramWithNickName:self.userName.text passwd:self.password.text email:self.email.text telNo:nil provinceID:nil cityID:nil collegeID:nil labName:nil majorID:nil educationID:nil titleID:nil nState:nil nSource:nil];
        }];
    
    RAC(self.confirmBtn,enabled) = compelValidSignal;
    
    [[[[self.confirmBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
      doNext:^(id x) {
          self.confirmBtn.enabled = NO;
      }]
     flattenMap:^RACStream *(id value) {
        return [self signUpSignal];
    }]
    subscribeNext:^(NSNumber *success) {
        if ([success boolValue]) {
            self.view.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
        }else
        {
            [MBProgressHUD showError:@"注册失败!"];
        }
        self.confirmBtn.enabled = YES;
    }];
}
- (RACSignal *)signUpSignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [LoginTool signUpWithParam:_signupParam completion:^(BOOL success) {
            [subscriber sendNext:@(success)];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}
@end
