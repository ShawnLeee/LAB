//
//  SXQInstructionDetail.m
//  实验助手
//
//  Created by sxq on 15/9/23.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <MJExtension/MJExtension.h>
#import "SXQInstructionDetail.h"
#import "SXQInstructionStep.h"
@implementation SXQInstructionDetail
+ (NSDictionary *)objectClassInArray
{
    return  @{@"steps" : [SXQInstructionStep class]};
}
@end
