//
//  SXQExpStepFrame.m
//  实验助手
//
//  Created by sxq on 15/10/14.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "SXQExpStepFrame.h"
#import "SXQExpStep.h"
#import "NSString+Size.h"
static const CGFloat kCellPadding = 10.0;
static const CGFloat kViewPadding = 10.0;
static const CGFloat kStepNumWidth = 60;
@implementation SXQExpStepFrame
- (void)setExpStep:(SXQExpStep *)expStep
{
    CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width - 2 * kCellPadding;
    _expStep = expStep;
    //stepNum
    CGFloat stepNumXY = kCellPadding;
    CGFloat stepNumW = kStepNumWidth;
    CGFloat stepNumH = 30;
    _stepNumFrame = CGRectMake(stepNumXY, stepNumXY, stepNumW, stepNumH);
    
    //stepDesc
    CGFloat stepDescX = CGRectGetMaxX(_stepNumFrame) + kViewPadding;
    CGFloat stepDescY = stepNumXY;
    CGFloat stepDescW = cellWidth - kCellPadding - stepNumW - kViewPadding ;
    CGSize descSize = [expStep.expStepDesc sizeWithFixedWidth:stepDescW font:15];
    _stepDescFrame = (CGRect){{stepDescX,stepDescY},descSize};
    if (expStep.processMemo) {
        CGFloat remarkX = stepNumXY;
        CGFloat remarkY = CGRectGetMaxY(_stepDescFrame) + kViewPadding;
        CGFloat remarkW = stepNumW;
        CGFloat remarkH = stepNumH;
        _remarkFrame = CGRectMake(remarkX, remarkY, remarkW, remarkH);
        
        CGFloat remarkContentX = stepDescX;
        CGFloat remarkContentY = remarkY;
        CGSize remarkContentSize = [expStep.processMemo sizeWithFixedWidth:stepDescW font:15];
        _remarkContentFrame = CGRectMake(remarkContentX, remarkContentY, remarkContentSize.width, remarkContentSize.height);
        
    }
    CGFloat padding = 8;
    if (expStep.images) {
        CGFloat photoX = stepNumXY;
        CGFloat photoY = 0;
        CGFloat photoW = cellWidth - 2 * kViewPadding;
        CGFloat photoH = 200;
        if (expStep.processMemo) {
            photoY = CGRectGetMaxY(_remarkContentFrame) + kViewPadding;
        }else
        {
            photoY = CGRectGetMaxY(_stepDescFrame) + kViewPadding;
        }
        _photosFrame = CGRectMake(photoX, photoY, photoW, photoH);
        _cellHeight = CGRectGetMaxY(_photosFrame)+ padding;
    }else
    {
        if (expStep.processMemo) {
            _cellHeight = MAX(CGRectGetMaxY(_remarkFrame),CGRectGetMaxY(_remarkContentFrame)) + padding * 1.5;
        }else
        {
            _cellHeight = MAX(CGRectGetMaxY(_stepNumFrame),CGRectGetMaxY(_stepDescFrame)) + padding;
        }
    }
    
}
@end
