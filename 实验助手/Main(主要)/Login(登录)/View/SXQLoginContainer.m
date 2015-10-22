//
//  SXQLoginContainer.m
//  实验助手
//
//  Created by sxq on 15/10/22.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQLoginViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SXQLoginContainer.h"
@interface SXQLoginContainer ()
@property (nonatomic,weak) IBOutlet UIView *view;
@property (nonatomic,assign) BOOL didSetupConstraints;
@property (nonatomic,weak) IBOutlet UITextField  *userNameField;
@property (nonatomic,weak) IBOutlet UITextField  *password;
@property (nonatomic,weak) IBOutlet UIButton *remenberBtn;
@property (nonatomic,weak) IBOutlet UIButton *forgetBtn;
@property (nonatomic,weak) IBOutlet UIButton *logBtn;
@property (nonatomic,weak) IBOutlet UIButton *signupBtn;
@end
@implementation SXQLoginContainer
- (instancetype)initWithLoginViewModel:(SXQLoginViewModel *)viewModel
{
    if (self = [super init]) {
        _viewModel = viewModel;
    }
    return self;
}
- (instancetype)init
{
    if (self = [super init]) {
        [[NSBundle mainBundle] loadNibNamed:@"SXQLoginContainer" owner:self options:nil];
        _didSetupConstraints = NO;
        [self p_addSubviews];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [[NSBundle mainBundle] loadNibNamed:@"SXQLoginContainer" owner:self options:nil];
        _didSetupConstraints = NO;
        [self p_addSubviews];
    }
    return self;
}
- (void)setViewModel:(SXQLoginViewModel *)viewModel
{
    _viewModel = viewModel;
    RAC(viewModel,username) = _userNameField.rac_textSignal;
    RAC(viewModel,password) = _password.rac_textSignal;
    _logBtn.rac_command = viewModel.loginCmd;
    
    [viewModel.loginCmd.executionSignals
    subscribeNext:^(NSNumber *ss) {
        [self endEditing:YES];
    }];
}
-(void)p_addSubviews
{
    _view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_view];
}

- (void)updateConstraints
{
    //Add constraints
    if (_didSetupConstraints == NO) {
        [self p_addConstraints];
        _didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}
- (void)p_addConstraints
{
    [self addConstraint:[_view.leadingAnchor constraintEqualToAnchor:self.leadingAnchor]];
    [self addConstraint:[_view.topAnchor constraintEqualToAnchor:self.topAnchor]];
    [self addConstraint:[_view.bottomAnchor constraintEqualToAnchor:self.bottomAnchor]];
    [self addConstraint:[_view.trailingAnchor constraintEqualToAnchor:self.trailingAnchor]];
}
+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
}
- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
}
@end
