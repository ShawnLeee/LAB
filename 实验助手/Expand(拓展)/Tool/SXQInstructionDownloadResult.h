//
//  SXQInstructionDownloadResult.h
//  实验助手
//
//  Created by sxq on 15/10/12.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class SXQInstructionData;
#import <Foundation/Foundation.h>

@interface SXQInstructionDownloadResult : NSObject
@property (nonatomic,copy) NSString *code;
@property (nonatomic,strong) SXQInstructionData *data;
@property (nonatomic,copy) NSString *msg;
@end
