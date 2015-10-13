//
//  SXQAnnotationView.m
//  实验助手
//
//  Created by sxq on 15/9/14.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//

#import "SXQAnnotationView.h"

@implementation SXQAnnotationView
- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        [[NSBundle mainBundle] loadNibNamed:@"SXQAnnotationView" owner:self options:nil];
        [self addSubview:_view];
    }
    return self;
}

@end
