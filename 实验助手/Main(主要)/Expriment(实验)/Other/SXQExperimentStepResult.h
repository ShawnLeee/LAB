//
//  SXQExperimentStepResult.h
//  实验助手
//
//  Created by sxq on 15/9/21.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
@class SXQExperiment;
#import <Foundation/Foundation.h>
@interface SXQExperimentStepResult : NSObject
@property (nonatomic,copy) NSString *code;
@property (nonatomic,strong) SXQExperiment *data;
@property (nonatomic,copy) NSString *msg;
@end
