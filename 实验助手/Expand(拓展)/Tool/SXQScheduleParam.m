//
//  SXQScheduleParam.m
//  实验助手
//
//  Created by sxq on 15/10/21.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "SXQScheduleParam.h"

@implementation SXQScheduleParam
+ (instancetype)paramWithDate:(NSString *)date
{
    SXQScheduleParam *param = [[SXQScheduleParam alloc] init];
    param.date = date;
    return param;
}
@end
