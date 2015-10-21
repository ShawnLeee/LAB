//
//  SXQScheduleImpl.m
//  实验助手
//
//  Created by sxq on 15/10/21.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <MJExtension/MJExtension.h>
#import "SXQHttpTool.h"
#import "SXQScheduleImpl.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SXQScheduleParam.h"
#import "SXQURL.h"
#import "SXQExperimentModel.h"
@implementation SXQScheduleImpl
- (RACSignal *)scheduleWithDate:(NSString *)date
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        SXQScheduleParam *param = [SXQScheduleParam paramWithDate:date];
        [SXQHttpTool getWithURL:ScheduleURL params:param.keyValues success:^(id json) {
            NSArray *arr = [SXQExperimentModel objectArrayWithKeyValuesArray:json[@"data"]];
            [subscriber sendNext:arr];
            [subscriber sendCompleted];
        } failure:^(NSError *error) {
            if (error) {
                [subscriber sendError:error];
            }
        }];
        return nil;
    }];
}
@end
