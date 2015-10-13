//
//  DWStepCell.m
//  实验助手
//
//  Created by sxq on 15/9/25.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "DWStepCell.h"
#import "SXQExperimentStep.h"
#import "UIImage+Size.h"
#import "PhotoContainer.h"
#import "SXQExpStep.h"
@interface DWStepCell ()
@property (weak, nonatomic) IBOutlet UILabel *stepLabel;
@property (weak, nonatomic) IBOutlet UILabel *stepContentLabel;
@property (weak, nonatomic) IBOutlet PhotoContainer *photoContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconHeightConst;
@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;
@end
@implementation DWStepCell
- (void)setExpProcess:(SXQExpStep *)expProcess
{
    _expProcess = expProcess;
    _stepLabel.text = [NSString stringWithFormat:@"%d",expProcess.stepNum];
    _stepContentLabel.text = expProcess.expStepDesc;
    _remarkLabel.text = expProcess.processMemo;
    _photoContainer.myImages = expProcess.images;
    _iconHeightConst.constant = expProcess.imageHeight;
}
- (void)addRemark:(NSString *)remark
{
    _remarkLabel.text = remark;
}
- (void)addImage:(UIImage *)image
{
    [_photoContainer addPhoto:image updatesConstraintBlk:^(BOOL success, CGFloat photoHeight) {
        if (success) {
            _iconHeightConst.constant = photoHeight;
            _expProcess.imageHeight = photoHeight;
        }else
        {
            
        }
    }];
}
@end
