//
//  SXQInstructionManager.m
//  实验助手
//
//  Created by sxq on 15/9/25.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQMyGenericInstruction.h"
#import "SXQDBManager.h"
#import "SXQInstructionManager.h"
#import <MJExtension/MJExtension.h>
@implementation SXQInstructionManager
+ (void)downloadInstruction:(SXQInstructionData *)instructionData completion:(CompletionHandler)completion
{
    [[SXQDBManager sharedManager] insertInstruciton:instructionData completion:^(BOOL success, NSDictionary *info) {
        completion(success,info);
    }];
}
+ (BOOL)instructionIsdownload:(NSString *)instrucitonID
{
//    [self fetchAllInstruction];
    return  [[SXQDBManager sharedManager] expInstrucitonExist:instrucitonID];
}
+ (NSArray *)fetchAllInstruction
{
    NSArray *dictArr = [[SXQDBManager sharedManager] chechAllInstuction];
    NSArray *modelArr =  [SXQMyGenericInstruction objectArrayWithKeyValuesArray:dictArr];
    return modelArr;
}
@end
