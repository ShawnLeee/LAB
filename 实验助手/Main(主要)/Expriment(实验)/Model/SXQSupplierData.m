//
//  SXQSupplierData.m
//  实验助手
//
//  Created by sxq on 15/10/15.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <MJExtension/MJExtension.h>
#import "SXQSupplierData.h"
#import "SXQSupplier.h"
#import "SXQEquipment.h"
#import "SXQReagent.h"
#import "SXQConsumable.h"
#import "SXQConsumableMap.h"
#import "SXQReagentMap.h"
#import "SXQEquipmentMap.h"
@implementation SXQSupplierData
+ (NSDictionary *)objectClassInArray
{
    return @{@"consumable" : [SXQConsumable class],@"consumableMap":[SXQConsumableMap class],@"reagent" : [SXQReagent class],@"reagentMap":[SXQReagentMap class],@"equipment" :[SXQEquipment class],@"equipmentMap" : [SXQEquipmentMap class],@"supplier" : [SXQSupplier class]};
}
@end
