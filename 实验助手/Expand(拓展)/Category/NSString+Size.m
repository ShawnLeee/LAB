//
//  NSString+Size.m
//  实验助手
//
//  Created by sxq on 15/10/14.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "NSString+Size.h"

@implementation NSString (Size)
- (CGSize)sizeWithFixedWidth:(CGFloat)width font:(CGFloat)font
{
    return [self boundingRectWithSize:CGSizeMake(width, width) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil].size;
}
@end
