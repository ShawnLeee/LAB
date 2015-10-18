//
//  SXQExperimentToolBar.m
//  实验助手
//
//  Created by sxq on 15/9/15.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SXQColor.h"
#import "SXQExperimentToolBar.h"
#import "SXQExpStep.h"
@interface SXQExperimentToolBar ()
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;
@property (weak, nonatomic) IBOutlet UIButton *reportBtn;
@property (weak, nonatomic) IBOutlet UIButton *photoBtn;
@property (weak, nonatomic) IBOutlet UIButton *remarkBtn;
@property (nonatomic,strong) UIButton *selectedBtn;
@end
@implementation SXQExperimentToolBar

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [[NSBundle mainBundle] loadNibNamed:@"SXQExperimentToolBar" owner:self options:nil];
        _view.frame = self.bounds;
        [self addSubview:_view];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [[NSBundle mainBundle] loadNibNamed:@"SXQExperimentToolBar" owner:self options:nil];
        _view.frame = frame;
        [self addSubview:_view];
        [self p_setupButtons];
    }
    return self;
}
- (void)setCurrentStep:(SXQExpStep *)currentStep
{
    _currentStep = currentStep;
    [RACObserve(currentStep, isUserTimer)
    subscribeNext:^(NSNumber *isUsing) {
        if ([isUsing boolValue]) {
            [_starBtn setTitle:@"暂停" forState:UIControlStateNormal];
        }else
        {
            [_starBtn setTitle:@"启动" forState:UIControlStateNormal];
        }
    }];
}
- (void)updateConstraints
{
    [super updateConstraints];
    CGFloat buttonWidth = self.frame.size.width / self.view.subviews.count;
    _widthConstraint.constant = buttonWidth;
}
- (void)awakeFromNib
{
    [self p_setupButtons];
}
- (void)p_setupButtons
{
    _starBtn.tag = ExperimentTooBarButtonTypeStart;
    _backBtn.tag = ExperimentTooBarButtonTypeBack;
    _reportBtn.tag = ExperimentTooBarButtonTypeReport;
    _photoBtn.tag = ExperimentTooBarButtonTypePhoto;
    _remarkBtn.tag = ExperimentTooBarButtonTypeRemark;
    [self.view.subviews enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        [button setTitleColor:ToolBarSeletedColor forState:UIControlStateNormal];
        [button setTitleColor:ToolBarNormalColor forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectedButton:) forControlEvents:UIControlEventTouchUpInside];
    }];
    [self selectedButton:self.view.subviews.firstObject];
}
- (void)selectedButton:(UIButton *)button
{
    self.selectedBtn = button;
    //通知代理
    if ([self.delegate respondsToSelector:@selector(experimentToolBar:clickButtonWithType:)]) {
        [self.delegate experimentToolBar:self clickButtonWithType:button.tag];
    }
}
- (void)setSelectedBtn:(UIButton *)selectedBtn
{
    
    if (_selectedBtn == selectedBtn) {
        return;
    }
    _selectedBtn.selected = NO;
    selectedBtn.selected = YES;
    _selectedBtn = selectedBtn;
    
    [self.view.subviews enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        if (!button.selected) {
            [button setBackgroundColor:ToolBarNormalColor];
        }else
        {
            [button setBackgroundColor:ToolBarSeletedColor];
        }
    }];
   
}
@end
