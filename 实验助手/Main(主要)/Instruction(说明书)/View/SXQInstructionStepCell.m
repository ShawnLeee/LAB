//
//  SXQInstructionStepCell.m
//  实验助手
//
//  Created by sxq on 15/9/23.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQInstructionStep.h"
#import "SXQInstructionStepCell.h"
@interface SXQInstructionStepCell ()
@property (weak, nonatomic) IBOutlet UILabel *stepLabel;
@property (weak, nonatomic) IBOutlet UILabel *stepContentLabel;
@end
@implementation SXQInstructionStepCell
- (void)configureCellWithItem:(SXQInstructionStep *)step
{
    _stepLabel.text = [NSString stringWithFormat:@"步骤 %@ (大约%@分钟)",step.stepNum,step.expStepTime];
    _stepContentLabel.text = step.expStepDesc;
}
@end
