//
//  SXQBaseParam.m
//  实验助手
//
//  Created by sxq on 15/10/21.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "AccountTool.h"
#import "SXQBaseParam.h"
#import "Account.h"
@implementation SXQBaseParam
- (instancetype)init
{
    if (self = [super init]) {
        _userID = [AccountTool account].userID;
    }
    return self;
}
@end
