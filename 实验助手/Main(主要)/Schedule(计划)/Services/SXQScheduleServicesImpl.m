//
//  SXQScheduleServicesImpl.m
//  实验助手
//
//  Created by sxq on 15/10/21.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "SXQScheduleImpl.h"
#import "SXQScheduleServicesImpl.h"
@interface SXQScheduleServicesImpl ()
@property (nonatomic,strong) SXQScheduleImpl *scheduleService;
@end
@implementation SXQScheduleServicesImpl
- (instancetype)init
{
    if (self = [super init]) {
        _scheduleService = [SXQScheduleImpl new];
    }
    return self;
}
- (id<SXQSchedule>)getServices
{
    return _scheduleService;
}
@end
