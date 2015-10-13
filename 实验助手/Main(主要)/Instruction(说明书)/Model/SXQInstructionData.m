//
//  SXQInstructionData.m
//  实验助手
//
//  Created by sxq on 15/10/12.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <MJExtension/MJExtension.h>
#import "SXQInstructionData.h"
#import "SXQExpConsumable.h"
#import "SXQExpEquipment.h"
#import "SXQExpReagent.h"
#import "SXQExpStep.h"
@implementation SXQInstructionData
+ (NSDictionary *)objectClassInArray
{
    return @{@"expConsumable" :[SXQExpConsumable class] ,@"expEquipment" : [SXQExpEquipment class], @"expProcess" : [SXQExpStep class] ,@"expReagent" : [SXQExpReagent class]};
}
@end
