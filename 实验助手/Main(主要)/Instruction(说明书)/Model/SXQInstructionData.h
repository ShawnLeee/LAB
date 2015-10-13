//
//  SXQInstructionData.h
//  实验助手
//
//  Created by sxq on 15/10/12.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class SXQExpInstruction;
#import <Foundation/Foundation.h>

@interface SXQInstructionData : NSObject
/**
 *  耗材
 */
@property (nonatomic,strong) NSArray *expConsumable;
/**
 *  设备
 */
@property (nonatomic,strong) NSArray *expEquipment;
/**
 *  说明书
 */
@property (nonatomic,strong) SXQExpInstruction *expInstructionMain;
/**
 *  实验步骤
 */
@property (nonatomic,strong) NSArray *expProcess;
/**
 *  试剂
 */
@property (nonatomic,strong) NSArray *expReagent;
@end
