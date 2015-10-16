//
//  SXQMyExperimentManager.m
//  实验助手
//
//  Created by sxq on 15/9/25.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQDBManager.h"
#import "SXQMyExperimentManager.h"
#import "SXQExpInstruction.h"
#import "SXQExperimentModel.h"
@implementation SXQMyExperimentManager
- (void)writeRemak:(NSString *)remark toExperiment:(NSString *)myExpID expStepID:(NSString *)expStepID
{
    [[SXQDBManager sharedManager] writeRemark:remark withExpId:myExpID expProcessID:expStepID];
}

+ (void)addExperimentWithInstructionData:(SXQInstructionData *)instructionData completion:(void (^)(BOOL, SXQExperimentModel *))completioin
{
    [[SXQDBManager sharedManager] addExpWithInstructionData:instructionData completion:^(BOOL success, SXQExperimentModel *experiment) {
        completioin(success,experiment);
    }];
}
@end

