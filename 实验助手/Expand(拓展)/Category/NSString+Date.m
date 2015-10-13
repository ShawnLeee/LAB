//
//  NSString+Date.m
//  实验助手
//
//  Created by sxq on 15/10/8.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "NSString+Date.h"

@implementation NSString (Date)
+ (NSString *)dw_currentDate
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    return [formatter stringFromDate:date];
}
+ (NSString *)dw_year
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    return [formatter stringFromDate:date];
}
+ (NSString *)dw_month
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM"];
    return [formatter stringFromDate:date];
}
@end
