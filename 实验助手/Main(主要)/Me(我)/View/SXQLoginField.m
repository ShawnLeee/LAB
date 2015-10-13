//
//  SXQLoginField.m
//  实验助手
//
//  Created by sxq on 15/9/11.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//

#import "SXQLoginField.h"
@interface SXQLoginField ()
@property (strong, nonatomic) IBOutlet UIView *view;
@end
@implementation SXQLoginField

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [[NSBundle mainBundle] loadNibNamed:@"SXQLoginField" owner:self options:nil];
        self.view.frame = self.bounds;
        [self addSubview:_view];
    }
    return self;
}

@end
