//
//  SXQSignUpView.m
//  实验助手
//
//  Created by sxq on 15/10/20.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "SXQSignUpView.h"
@interface SXQSignUpView ()
@property (nonatomic,weak) IBOutlet UIScrollView *scrollView;
@end
@implementation SXQSignUpView
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [[NSBundle mainBundle] loadNibNamed:@"SXQSignUpView" owner:self options:nil];
        self.backgroundColor = [UIColor redColor];
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_scrollView];
    }
    return self;
}
- (void)awakeFromNib
{
    [self layoutCostomView];
    [self layoutIfNeeded];
}
- (void)layoutCostomView
{
    [self addConstraint:[_scrollView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:10]];
    [self addConstraint:[_scrollView.topAnchor constraintEqualToAnchor:self.topAnchor constant:10]];
    [self addConstraint:[_scrollView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-10]];
    [self addConstraint:[_scrollView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-10]];
}

@end
