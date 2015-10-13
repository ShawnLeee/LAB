//
//  SXQSaveReagentController.m
//  实验助手
//
//  Created by sxq on 15/9/29.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SXQSaveReagentController.h"
#import "SXQExperimentStep.h"
@interface SXQSaveReagentController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic,strong) SXQExperimentStep *experimentStep;
@property (nonatomic,weak) UIButton *confirmBtn;
@property (nonatomic,copy) void (^completion)();
@end

@implementation SXQSaveReagentController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self p_setupSelf];
    [self p_setupNav];
    [self binding];
}
- (instancetype)initWithExperimentStep:(SXQExperimentStep *)experimentStep
{
    if (self = [super init]) {
        _experimentStep = experimentStep;
    }
    return self;
}
- (instancetype)initWithExperimentStep:(SXQExperimentStep *)experimentStep completion:(void (^)())completion
{
    SXQSaveReagentController *vc = [self initWithExperimentStep:experimentStep];
    vc.completion = completion;
    return vc;
}
- (void)p_setupSelf
{
    _textView.text = _experimentStep.depositReagent;
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 40, 30);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"保存试剂";
    self.navigationItem.titleView = label;
    [_textView becomeFirstResponder];
}
- (void)p_setupNav
{
    UIButton *button = [[UIButton alloc] init];
    
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    button.frame = CGRectMake(0, 0, 40, 30);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.navigationController dismissViewControllerAnimated:YES completion:self.completion];
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
    RAC(_confirmBtn,enabled) = [_textView.rac_textSignal map:^id(NSString *text) {
        return @(text.length > 0);
    }];
    [[_confirmBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        _experimentStep.depositReagent = _textView.text;
        [self.navigationController dismissViewControllerAnimated:YES completion:self.completion];
    }];
}
@end
