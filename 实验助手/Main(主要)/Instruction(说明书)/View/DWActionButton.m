//
//  DWActionButton.m
//  实验助手
//
//  Created by sxq on 15/9/23.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWActionButton.h"
static CGFloat kImageRatio = 0.6;
@implementation DWActionButton
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return self;
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height * kImageRatio);
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, contentRect.size.height * kImageRatio, contentRect.size.width, contentRect.size.height * (1 - kImageRatio));
}
- (void)setHighlighted:(BOOL)highlighted{}
@end
