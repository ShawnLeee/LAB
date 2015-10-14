//
//  NSString+Size.h
//  实验助手
//
//  Created by sxq on 15/10/14.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
@interface NSString (Size)
- (CGSize)sizeWithFixedWidth:(CGFloat)width font:(CGFloat)font;
@end
