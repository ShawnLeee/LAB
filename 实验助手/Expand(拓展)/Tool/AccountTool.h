//
//  AccountTool.h
//  实验助手
//
//  Created by sxq on 15/10/8.
//  Copyright © 2015年 SXQ. All rights reserved.
//

@class Account;
#import <Foundation/Foundation.h>

@interface AccountTool : NSObject
/**
 *  存储账号
 *
 */
+ (BOOL)saveAccount:(Account *)account;
/**
 *  取账号
 */
+ (Account *)account;
@end
