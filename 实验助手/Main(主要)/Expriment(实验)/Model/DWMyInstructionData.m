//
//  DWMyInstructionData.m
//  实验助手
//
//  Created by sxq on 15/9/30.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWGroup.h"
#import "SXQMyGenericInstruction.h"
#import "DWMyInstructionData.h"
#import "SXQInstructionManager.h"
#import "SXQMyInstructionCell.h"
#import "InstructionTool.h"
#import "SXQHotInstruction.h"
#import "SXQHotInstructionCell.h"

@interface DWMyInstructionData ()
@property (nonatomic,strong,readwrite) NSArray *groups;
@end
@implementation DWMyInstructionData
+ (instancetype)instructionDataWithDataLoadCompletedBlock:(DataLoadCompletedBlock)completionBlk
{
    DWMyInstructionData *instructionData = [[DWMyInstructionData alloc] init];
    instructionData.dataLoadCompletedBlk = [completionBlk copy];
    return instructionData;
}
- (NSArray *)groups
{
    if (_groups == nil) {
        DWGroup *group0 = [self setupGroup0];
        DWGroup *group1 = [self setupGroup1];
        _groups = @[group0,group1];
    }
    return _groups;
}
- (DWGroup *)setupGroup0
{
     NSArray *arr = [SXQInstructionManager fetchAllInstruction];
        DWGroup *group0 = [DWGroup groupWithItems:arr identifier:MyInstructionIdentifier header:@"我的常用说明书"];
        group0.configureBlk = ^(SXQMyInstructionCell *cell,SXQMyGenericInstruction *item){
            [cell configureCellForItem:item];
        };
    return group0;
}
- (DWGroup *)setupGroup1
{
    __block DWGroup *group = [DWGroup groupWithItems:@[] identifier:HotInstructionIdentifier header:@"热门说明书"];
    group.configureBlk = ^(SXQHotInstructionCell *cell,SXQHotInstruction *hotInstruction){
        [cell configureCellWithItem:hotInstruction];
                        };
    [InstructionTool fetchHotInstructionsSuccess:^(HotInstructionResult *result) {
        group.items = result.data;
        _dataLoadCompletedBlk();
    } failure:^(NSError *error) {
        
    }];
    return group;
}

@end
