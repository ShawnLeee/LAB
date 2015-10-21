//
//  SXQCountTimeView.m
//  实验助手
//
//  Created by sxq on 15/10/21.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "SXQCountTimeView.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface SXQCountTimeView ()
@property (nonatomic,weak) IBOutlet UIView *view;
@property (nonatomic,weak) IBOutlet UIButton *confirmBtn;
@property (nonatomic,weak) IBOutlet UIButton *cancelBtn;
@property (nonatomic,weak) IBOutlet UIDatePicker *pickerView;
@end
@implementation SXQCountTimeView
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}
- (void)setup
{
    [[NSBundle mainBundle] loadNibNamed:@"SXQCountTimeView" owner:self options:nil];
    _view.translatesAutoresizingMaskIntoConstraints = NO;
    _pickerView.datePickerMode = UIDatePickerModeCountDownTimer;
    [self addSubview:_view];
    _view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self setupCustomView];
}
- (IBAction)confirm:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(countTimeView:choosedTime:)]) {
        [_delegate countTimeView:self choosedTime:self.pickerView.countDownDuration];
    }
}
- (IBAction)cancel:(UIButton *)sender {
    [UIView animateWithDuration:0.5 animations:^{
        self.hidden = YES;
    }];
}

- (instancetype)init
{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}
- (void)setupCustomView
{
    [self addConstraint:[self.view.leadingAnchor constraintEqualToAnchor:self.leadingAnchor]];
    [self addConstraint:[self.view.topAnchor constraintEqualToAnchor:self.topAnchor]];
    [self addConstraint:[self.view.trailingAnchor constraintEqualToAnchor:self.trailingAnchor]];
    [self addConstraint:[self.view.bottomAnchor constraintEqualToAnchor:self.bottomAnchor]];
}
- (void)show
{
    self.frame = [UIScreen mainScreen].bounds;
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.5 animations:^{
        self.hidden = NO;
    }];
}
- (void)hide
{
    [UIView animateWithDuration:0.5 animations:^{
        self.hidden = YES;
    }];
}
@end
