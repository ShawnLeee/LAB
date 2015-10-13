//
//  SXQSegmentedControll.m
//  实验助手
//
//  Created by sxq on 15/9/14.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//

#import "SXQSegmentedControll.h"

@implementation SXQSegmentedControll

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [[NSBundle mainBundle] loadNibNamed:@"SXQSegmentedControll" owner:self options:nil];
        _view.frame = frame;
        [self addSubview:_view];
    }
    return self;
}

@end
