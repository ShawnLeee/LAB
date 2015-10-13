//
//  SXQStepCell.m
//  实验助手
//
//  Created by sxq on 15/9/18.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//

#import "SXQStepCell.h"
#import "SXQExperimentStep.h"
@interface SXQStepCell ()
@property (weak, nonatomic) IBOutlet UILabel *step;
@property (weak, nonatomic) IBOutlet UILabel *stepContent;
@end
@implementation SXQStepCell
- (void)configureCellWithModel:(SXQExperimentStep *)model
{
    _step.text = [NSString stringWithFormat:@"步骤%@:",model.stepNum];
    _stepContent.text = model.stepDesc;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
