//
//  SXQLoginImpl.m
//  实验助手
//
//  Created by sxq on 15/10/22.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "LoginTool.h"
#import "SXQLoginImpl.h"

@implementation SXQLoginImpl
- (RACSignal *)loginSignalWithUsername:(NSString *)username password:(NSString *)password
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [LoginTool loginWithUserName:username password:password completion:^(BOOL success) {
            [subscriber sendNext:@(success)];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}
@end
