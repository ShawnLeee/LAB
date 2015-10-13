//
//  SXQSaveReagentController.h
//  实验助手
//
//  Created by sxq on 15/9/29.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class SXQExperimentStep;
#import <UIKit/UIKit.h>

@interface SXQSaveReagentController : UIViewController
- (instancetype)initWithExperimentStep:(SXQExperimentStep *)experimentStep;
- (instancetype)initWithExperimentStep:(SXQExperimentStep *)experimentStep completion:(void (^)())completion;
@end
