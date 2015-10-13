//
//  SXQRemarkController.m
//  实验助手
//
//  Created by sxq on 15/9/25.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SXQExpStep.h"
#import "SXQRemarkController.h"

@interface SXQRemarkController ()
@property (weak, nonatomic) IBOutlet UITextView *remarkView;
@property (nonatomic,strong) SXQExpStep *experimentStep;
@property (nonatomic,weak) UIButton *confirmBtn;
@end

@implementation SXQRemarkController
- (instancetype)initWithExperimentStep:(SXQExpStep *)experimentStep
{
    if (self = [super init]) {
        _experimentStep = experimentStep;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupSelf];
    [self p_setupNav];
    [self binding];
}
- (void)p_setupSelf
{
    
    _remarkView.text = _experimentStep.processMemo;
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 40, 30);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"写备注";
    self.navigationItem.titleView = label;
    [_remarkView becomeFirstResponder];
}
- (void)p_setupNav
{
    UIButton *button = [[UIButton alloc] init];
    
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    button.frame = CGRectMake(0, 0, 40, 30);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn = rightBtn;
    rightBtn.enabled = NO;
    rightBtn.frame = CGRectMake(0, 0, 40, 30);
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}
- (void)binding
{

    RAC(_confirmBtn,enabled) = [_remarkView.rac_textSignal map:^id(NSString *text) {
        return @(text.length > 0);
    }];
    [[_confirmBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        _experimentStep.processMemo = _remarkView.text;
        [_experimentStep saveProcessMemo:_remarkView.text];
        NSString *remark = [NSString stringWithFormat:@"备注:%@",_remarkView.text];
        _addRemarkBlk(_remarkView.text);
        [self.navigationController dismissViewControllerAnimated:YES completion:self.completion];
    }];
}

@end
