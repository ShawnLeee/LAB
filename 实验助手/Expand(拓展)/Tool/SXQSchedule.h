//
//  SXQSchedule.h
//  实验助手
//
//  Created by sxq on 15/10/21.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class RACSignal,NSString;
#import <Foundation/Foundation.h>

@protocol SXQSchedule <NSObject>
- (RACSignal *)scheduleWithDate:(NSString *)date;
@end
