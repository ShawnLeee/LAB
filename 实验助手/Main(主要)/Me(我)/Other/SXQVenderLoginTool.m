//
//  SXQVenderLoginTool.m //  实验助手
//
//  Created by sxq on 15/9/11.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
#import <ShareSDK/ShareSDK.h>
#import <Parse/Parse.h>
#import "SXQVenderLoginTool.h"

@implementation SXQVenderLoginTool
+ (void)venderLoginWithLoginType:(VenderLoginType)loginType completion:(LoginCompletionBlk)completion
{
    switch (loginType) {
        case VenderLoginTypeWeibo:
            [self weiBoLogin:completion];
            break;
        case VenderLoginTypeQQ:
            [self qqLogin:completion];
            break;
        case VenderLoginTypeWeChat:
            [self wxLogin:completion];
            break;
    }
}
/**
 *  Sina Weibo login
 */
+ (void)weiBoLogin:(LoginCompletionBlk)completion {
    [ShareSDK
     getUserInfoWithType:ShareTypeSinaWeibo
     authOptions:nil
     result:^(BOOL result, id<ISSPlatformUser> userInfo,
              id<ICMErrorInfo> error) {
         if (result) {
             PFQuery *query =
             [PFQuery queryWithClassName:@"UserInfo"];
             [query whereKey:@"uid" equalTo:[userInfo uid]];
             [query
              findObjectsInBackgroundWithBlock:^(NSArray *objects,
                                                 NSError *error) {
                  
                  if ([objects count] == 0) {
                      PFObject *newUser =
                      [PFObject objectWithClassName:@"UserInfo"];
                      [newUser setObject:[userInfo uid] forKey:@"uid"];
                      [newUser setObject:[userInfo nickname]
                                  forKey:@"name"];
                      [newUser setObject:[userInfo profileImage]
                                  forKey:@"icon"];
                      [newUser saveInBackground];
                      
//                      UIAlertView *alertView = [[UIAlertView alloc]
//                                                initWithTitle:@"Hello"
//                                                message:@"欢迎注册"
//                                                delegate:nil
//                                                cancelButtonTitle:@"知道了"
//                                                otherButtonTitles:nil];
//                      [alertView show];
                  } else {
                      
//                      UIAlertView *alertView = [[UIAlertView alloc]
//                                                initWithTitle:@"Hello"
//                                                message:@"欢迎回来"
//                                                delegate:nil
//                                                cancelButtonTitle:@"知道了"
//                                                otherButtonTitles:nil];
//                      [alertView show];
                  }
              }];
         }
         completion(result);
         
     }];
}
/**
 *  WeChat login
 */
+ (void)wxLogin:(LoginCompletionBlk)completion {
}
/**
 *  QQ login
 */
+ (void)qqLogin:(LoginCompletionBlk)completion {
}
@end
