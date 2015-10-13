//
//  SXQCurrentExperimentData.h
//  实验助手
//
//  Created by sxq on 15/10/12.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class SXQMyExperiment,SXQExpStep;
#import <Foundation/Foundation.h>

@interface SXQCurrentExperimentData : NSObject
@property (nonatomic,strong) SXQMyExperiment *myExperiment;
@property (nonatomic,strong) NSArray *expProcesses;
+ (instancetype)currentExprimentDataWith:(SXQMyExperiment *)myExperiment expProcesses:(NSArray *)expProcesses;
- (instancetype)initWithMyExpId:(NSString *)myExpId completion:(void (^)(BOOL success))completion;
@end
