//
//  DWMyInstructionData.h
//  实验助手
//
//  Created by sxq on 15/9/30.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#define MyInstructionIdentifier @"SXQMyInstructionCell"
#define HotInstructionIdentifier @"Hot Instruction Cell"

#import <Foundation/Foundation.h>

typedef void (^DataLoadCompletedBlock)();
@interface DWMyInstructionData : NSObject
@property (nonatomic,strong,readonly) NSArray *groups;
@property (nonatomic,copy) DataLoadCompletedBlock dataLoadCompletedBlk;
+ (instancetype)instructionDataWithDataLoadCompletedBlock:(DataLoadCompletedBlock)completionBlk;
@end
