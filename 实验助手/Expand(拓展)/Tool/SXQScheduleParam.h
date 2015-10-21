//
//  SXQScheduleParam.h
//  实验助手
//
//  Created by sxq on 15/10/21.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "SXQBaseParam.h"

@interface SXQScheduleParam : SXQBaseParam
@property (nonatomic,copy) NSString *date;
+ (instancetype)paramWithDate:(NSString *)date;
@end
