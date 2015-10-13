//
//  UIImage+Size.h
//  实验助手
//
//  Created by sxq on 15/9/28.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Size)
/**
*  限定宽度，根据图片的宽高比，拉伸一张图片
*
*  @param width 限定的目标图片宽度
*
*  @return 拉伸后图片的高度
*/
- (CGFloat)imageHeightConstraintToWidth:(CGFloat)width;
@end
