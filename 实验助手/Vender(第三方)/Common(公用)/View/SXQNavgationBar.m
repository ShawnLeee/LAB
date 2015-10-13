//
//  SXQNavgationBar.m
//  Container Transitions
//
//  Created by Daniel on 15/8/31.
//
//

#import "SXQNavgationBar.h"

static CGFloat const kButtonSlotWidth = 64; // Also distance between button centers
static CGFloat const kButtonSlotHeight = 44;

@interface SXQNavgationBar ()
@property (nonatomic,weak) UIView *privateButtonsView;
@property (nonatomic,strong) NSArray *viewControllers;
@end
@implementation SXQNavgationBar
- (instancetype)initWithViewControllers:(NSArray *)viewControllers
{
    if (self = [super init]) {
        _viewControllers = viewControllers;
        UIView *privateButtonsView = [[UIView alloc] init];
        privateButtonsView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:privateButtonsView];
        _privateButtonsView = privateButtonsView;
        self.backgroundColor = [UIColor whiteColor];
        _privateButtonsView.backgroundColor = [UIColor whiteColor];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_privateButtonsView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_privateButtonsView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:_viewControllers.count * kButtonSlotWidth]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_privateButtonsView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_privateButtonsView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
        [self addChildViewControllerButtons];
    }
    return self;
}
- (void)addChildViewControllerButtons
{
    [self.viewControllers enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger idx, BOOL *stop) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:viewController.title forState:UIControlStateNormal];
        button.tag = idx;
        [button addTarget:self action:@selector(p_buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [_privateButtonsView addSubview:button];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        
        [_privateButtonsView addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_privateButtonsView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:(idx + 0.5f) * kButtonSlotWidth]];
        [_privateButtonsView addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_privateButtonsView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    }];
    
}
- (void)p_buttonTapped:(UIButton *)button
{
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}
@end
