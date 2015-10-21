//
//  AccountTool.m
//  实验助手
//
//  Created by sxq on 15/10/8.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "AccountTool.h"
#import "Account.h"
#define IWAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]
@implementation AccountTool
+ (BOOL)saveAccount:(Account *)account
{
    BOOL success = [NSKeyedArchiver archiveRootObject:account toFile:IWAccountFile];
    return success;
}
+ (Account *)account
{
    Account *ac = [NSKeyedUnarchiver unarchiveObjectWithFile:IWAccountFile];
    return ac;
}
@end
