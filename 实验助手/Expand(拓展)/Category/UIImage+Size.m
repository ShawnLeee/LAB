//
//  UIImage+Size.m
//  实验助手
//
//  Created by sxq on 15/9/28.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@import AVFoundation;
#import "UIImage+Size.h"

@implementation UIImage (Size)
- (CGFloat)imageHeightConstraintToWidth:(CGFloat)width
{
    CGRect boudingRect = CGRectMake(0, 0, width, MAXFLOAT);
    CGRect resultRect = AVMakeRectWithAspectRatioInsideRect(self.size, boudingRect);
    return resultRect.size.height;
}
@end
