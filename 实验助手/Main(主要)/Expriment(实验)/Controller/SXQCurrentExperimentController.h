//
//  SXQCurrentExperimentController.h
//  实验助手
//
//  Created by sxq on 15/9/15.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
@class SXQExperimentModel,SXQCurrentExperimentData;
#import <UIKit/UIKit.h>

@interface SXQCurrentExperimentController : UIViewController
@property (nonatomic,strong) SXQExperimentModel *experimentModel;
- (instancetype)initWithExperimentModel:(SXQExperimentModel *)experimentModel;
@end
