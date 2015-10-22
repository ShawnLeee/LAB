//
//  LoginTool.m
//  实验助手
//
//  Created by sxq on 15/9/22.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
#import "SXQURL.h"
#import "Account.h"
#import "AccountTool.h"
#import "SXQHttpTool.h"
#import <MJExtension/MJExtension.h>
#import "LoginTool.h"
////////////////////////////////////////SignUpParam/////////////////////////////////////////////////////////////////
@interface SignUpParam ()
@end
@implementation SignUpParam
+ (instancetype)paramWithNickName:(NSString *)nickName passwd:(NSString *)pwd email:(NSString *)email telNo:(NSString *)tel provinceID:(NSString *)provinceID cityID:(NSString *)cityID collegeID:(NSString *)collegeID labName:(NSString *)labName majorID:(NSString *)majorID educationID:(NSString *)educationID titleID:(NSString *)titleID nState:(NSString *)nState nSource:(NSString *)nSource
{
    SignUpParam *param = [SignUpParam new];
    param.nickName = nickName;
    param.pwd = pwd;
    param.eMail = email;
    param.telNo = tel;
    param.provinceID = provinceID;
    param.cityID = cityID;
    param.collegeID = collegeID;
    param.labName = labName;
    param.majorID = majorID;
    param.educationID = educationID;
    param.titleID = titleID;
    param.nState = nState;
    param.nSource = nSource;
    return param;
}
@end
////////////////////////////////////////SignUpParam/////////////////////////////////////////////////////////////////


////////////////////////////////////////LoginParam/////////////////////////////////////////////////////////////////
@interface LoginParam ()
@end
@implementation LoginParam
+ (instancetype)paramWithNickName:(NSString *)nickName passwd:(NSString *)pwd
{
    LoginParam *param = [[LoginParam alloc] init];
    param.nickName = nickName;
    param.pwd = pwd;
    return param;
}
@end
////////////////////////////////////////LoginParam/////////////////////////////////////////////////////////////////


////////////////////////////////////////LoginTool/////////////////////////////////////////////////////////////////
@implementation LoginTool
+ (void)signUpWithParam:(SignUpParam *)param completion:(CompletionBlock)completion
{
    [SXQHttpTool postWithURL:SignUpURL params:param.keyValues success:^(id json) {
        if (completion) {
            BOOL success = [(NSString *)json[@"code"] isEqualToString:@"1"] ? YES : NO;
            completion(success);
        }
    } failure:^(NSError *error) {
        
    }];
}
+ (void)loginWithParam:(LoginParam *)param completion:(CompletionBlock)completion
{
    [SXQHttpTool postWithURL:LoginURL params:param.keyValues success:^(id json) {
        LoginResult *result = [LoginResult objectWithKeyValues:json];
        if (result.code == 1) {
            //保存账号
            Account *acc = [Account objectWithKeyValues:json[@"data"]];
            [AccountTool saveAccount:acc];
        }
        completion(result.code == 1 ? YES : NO);
    } failure:^(NSError *error) {
        
    }];
}
+ (void)loginWithUserName:(NSString *)userName password:(NSString *)password completion:(void (^)(BOOL))completion
{
    LoginParam *param = [LoginParam paramWithNickName:userName passwd:password];
    [self loginWithParam:param completion:^(BOOL success) {
        completion(success);
    }];
}
@end
////////////////////////////////////////LoginTool/////////////////////////////////////////////////////////////////
@implementation LoginResult

@end