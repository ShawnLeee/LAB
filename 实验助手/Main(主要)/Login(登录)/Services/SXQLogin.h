//
//  SXQLogin.h
//  实验助手
//
//  Created by sxq on 15/10/22.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
@protocol SXQLogin <NSObject>

- (RACSignal *)loginSignalWithUsername:(NSString *)username password:(NSString *)password;

@end
