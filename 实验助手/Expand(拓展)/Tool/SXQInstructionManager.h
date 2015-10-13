//
//  SXQInstructionManager.h
//  实验助手
//
//  Created by sxq on 15/9/25.
//  Copyright © 2015年 SXQ. All rights reserved.
//

@class SXQInstructionData;
#import <Foundation/Foundation.h>
typedef void (^CompletionHandler)(BOOL success,NSDictionary *info);
@interface SXQInstructionManager : NSObject
/**
 *  下载实验说明书
 */
+ (void)downloadInstruction:(SXQInstructionData *)instructionData completion:(CompletionHandler)completion;
/**
 *  查询说明书是否下载
 */
+ (BOOL)instructionIsdownload:(NSString *)instrucitonID;
/**
 *  获取所有已下载的说明书
 *
 *  @return 已下载说明书字典数组
 */
+ (NSArray *)fetchAllInstruction;
@end
