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
#import "PhotoContainer.h"
static const CGFloat kCellPadding = 10.0;
static const CGFloat kViewPadding = 10.0;
static const CGFloat kStepNumWidth = 60;
@implementation SXQExpStepFrame
- (void)setExpStep:(SXQExpStep *)expStep
{
    if (_expStep == nil) {
        [expStep addObserver:self forKeyPath:@"processMemo" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        [expStep addObserver:self forKeyPath:@"images" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld  context:nil];
    }
    CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width;
    _expStep = expStep;
    //stepNum
    CGFloat stepNumXY = 0;
    CGFloat stepNumW = kStepNumWidth;
    CGFloat stepNumH = 21;
    _stepNumFrame = CGRectMake(stepNumXY, stepNumXY, stepNumW, stepNumH);
    
    //stepDesc
    CGFloat stepDescX = CGRectGetMaxX(_stepNumFrame) + kViewPadding;
    CGFloat stepDescY = stepNumXY;
    CGFloat stepDescW = cellWidth - kCellPadding - stepNumW - kViewPadding;
    CGSize descSize = [expStep.expStepDesc sizeWithFixedWidth:stepDescW font:15];
    _stepDescFrame = (CGRect){{stepDescX,stepDescY},descSize};
    if (expStep.processMemo.length) {
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
    CGFloat timeLabelY = 0;
    if (expStep.images.count) {
        CGSize photoSize = [PhotoContainer photosViewSizeWithPhotosCount:expStep.images.count];
        CGFloat photoX = stepNumXY;
        CGFloat photoY = 0;
        if (expStep.processMemo.length) {
            photoY = CGRectGetMaxY(_remarkContentFrame) + kViewPadding;
        }else
        {
            photoY = CGRectGetMaxY(_stepDescFrame) + kViewPadding;
        }
        _photosFrame = CGRectMake(photoX, photoY, photoSize.width, photoSize.height);
        timeLabelY = CGRectGetMaxY(_photosFrame)+ kViewPadding;
    }else
    {
        if (expStep.processMemo.length) {
            timeLabelY = MAX(CGRectGetMaxY(_remarkFrame),CGRectGetMaxY(_remarkContentFrame)) + padding *2;
        }else
        {
            timeLabelY = MAX(CGRectGetMaxY(_stepNumFrame),CGRectGetMaxY(_stepDescFrame)) + padding;
        }
    }
    _timeLabelFrame = CGRectMake(kCellPadding, timeLabelY, cellWidth - 4 * kCellPadding, 30);
    _cellHeight = CGRectGetMaxY(_timeLabelFrame) + kViewPadding;
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    self.expStep = (SXQExpStep *)object;
}
- (void)dealloc
{
    [self.expStep removeObserver:self forKeyPath:@"processMemo"];
    [self.expStep removeObserver:self forKeyPath:@"images"];
}
@end
