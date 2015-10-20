//
//  LoginTool.h
//  实验助手
//
//  Created by sxq on 15/9/22.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CompletionBlock)(BOOL success);

////////////////////////////////////////LoginParam/////////////////////////////////////////////////////////////////
@interface LoginParam : NSObject
@property (nonatomic,copy) NSString *nickName;
@property (nonatomic,copy) NSString *pwd;
+ (instancetype)paramWithNickName:(NSString *)nickName passwd:(NSString *)pwd;
@end
////////////////////////////////////////LoginParam/////////////////////////////////////////////////////////////////
@interface LoginResult : NSObject
@property (nonatomic,copy) NSString *userID;
@property (nonatomic,assign) int code;
@property (nonatomic,copy) NSString *msg;
@end

////////////////////////////////////////SignUpParam/////////////////////////////////////////////////////////////////
@interface SignUpParam : LoginParam

@property (nonatomic,copy) NSString *eMail;
@property (nonatomic,copy) NSString *telNo;
@property (nonatomic,copy) NSString *provinceID;
@property (nonatomic,copy) NSString *cityID;
@property (nonatomic,copy) NSString *collegeID;
@property (nonatomic,copy) NSString *labName;
@property (nonatomic,copy) NSString *majorID;
@property (nonatomic,copy) NSString *educationID;
@property (nonatomic,copy) NSString *titleID;
@property (nonatomic,copy) NSString *nState;
@property (nonatomic,copy) NSString *nSource;
+ (instancetype)paramWithNickName:(NSString *)nickName
                           passwd:(NSString *)pwd
                            email:(NSString *)email
                            telNo:(NSString *)tel
                       provinceID:(NSString *)provinceID
                           cityID:(NSString *)cityID
                        collegeID:(NSString *)collegeID
                          labName:(NSString *)labName
                          majorID:(NSString *)majorID
                      educationID:(NSString *)educationID
                          titleID:(NSString *)titleID
                           nState:(NSString *)nState
                          nSource:(NSString *)nSource;
@end
////////////////////////////////////////SignUpParam/////////////////////////////////////////////////////////////////


////////////////////////////////////////LoginTool/////////////////////////////////////////////////////////////////
@interface LoginTool : NSObject
+ (void)signUpWithParam:(SignUpParam *)param completion:(CompletionBlock)completion;
+ (void)loginWithParam:(LoginParam *)param completion:(CompletionBlock)completion;
+ (void)loginWithUserName:(NSString *)userName
                 password:(NSString *)password
               completion:(void (^)(BOOL success))completion;

@end
////////////////////////////////////////LoginTool/////////////////////////////////////////////////////////////////


