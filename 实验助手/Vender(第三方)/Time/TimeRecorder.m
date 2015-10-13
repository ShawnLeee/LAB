//
//  TimeRecorder.m
//  TimeMachine
//
//  Created by sxq on 15/9/21.
//  Copyright (c) 2015年 sxq. All rights reserved.
//
#import "MZTimerLabel.h"
#import "TimeRecorder.h"
@interface TimeRecorder ()<MZTimerLabelDelegate>
@property (nonatomic,strong) MZTimerLabel *recordLabel;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *continueBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (nonatomic,assign) BOOL isCounting;
@end
@implementation TimeRecorder
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self p_loadNibFile];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self p_loadNibFile];
    }
    return self;
}
- (void)p_loadNibFile
{
    [[NSBundle mainBundle] loadNibNamed:@"TimeRecorder" owner:self options:nil];
    
    //初始化timealbel
    _recordLabel = [[MZTimerLabel alloc] initWithLabel:_timeLabel andTimerType:MZTimerLabelTypeTimer];
    _recordLabel.delegate = self;
    
    self.isCounting = NO;
    _datePicker.hidden = NO;
    _timeLabel.hidden = YES;
    _pauseButton.enabled = self.isCounting;
    _continueBtn.enabled = NO;
    
    _timeRecorderView.frame = self.frame;
    _datePicker.datePickerMode = UIDatePickerModeCountDownTimer;
    [self addSubview:_timeRecorderView]; 
}
- (IBAction)starBtnClicked:(UIButton *)sender {
        //显示计时器,隐藏时间选择
        _timeLabel.hidden = NO;
        _datePicker.hidden = YES;
        //开始计时
        [self startTimeRecordWithTime:_datePicker.countDownDuration];
    sender.hidden = YES;
}
- (IBAction)cancelTimer {
    [self pauseTimer];
    if ([self.delegate respondsToSelector:@selector(timeRecorderdidCancel:)]) {
        [self.delegate timeRecorderdidCancel:self];
    }
}
- (IBAction)continueTimer {
    [self startTimer];
}
- (void)setIsCounting:(BOOL)isCounting
{
    _isCounting = isCounting;
    _pauseButton.enabled = isCounting;
    _continueBtn.enabled = !_pauseButton.enabled;
//    _startButton.enabled = (!isCounting && !_pauseButton.enabled &&!_continueBtn.enabled);
}
- (IBAction)pauseBtnClicked:(UIButton *)sender {
    [self pauseTimer];
    if ([_delegate respondsToSelector:@selector(timeRecorderdidPaused:)]) {
        [_delegate timeRecorderdidPaused:self];
    }

}
- (void)startTimeRecordWithTime:(NSTimeInterval)times
{
    [_recordLabel setCountDownTime:times];
    [self startTimer];
}
/**
 *  重置计时器
 */
- (void)resetTimer
{
    //隐藏计时器,显示时间选择
    _timeLabel.hidden = YES;
    _datePicker.hidden = NO;
    //重置计时器
    [_recordLabel reset];
    self.isCounting = NO;
}
- (void)timerLabel:(MZTimerLabel *)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime
{
    if ([self.delegate respondsToSelector:@selector(timeRecorder:finishedTimerWithTime:)]) {
        [self.delegate timeRecorder:self finishedTimerWithTime:countTime];
    }
}
- (void)updateConstraints
{
    [super updateConstraints];
    self.timeRecorderView.frame = self.bounds;
}
+ (instancetype)showTimer
{
    CGFloat timerHeight = 250;
    CGRect screenRect = [UIScreen mainScreen].bounds;
    TimeRecorder *timer = [[TimeRecorder alloc] initWithFrame:CGRectMake(0, screenRect.size.height - timerHeight, screenRect.size.width, timerHeight)];
    [[UIApplication sharedApplication].keyWindow addSubview:timer];
    return timer;
}
- (void)hideTimer
{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)startTimer
{
    [_recordLabel start];
    self.isCounting = YES;
}
- (void)pauseTimer
{
    [_recordLabel pause];
    self.isCounting = NO;
}
@end
