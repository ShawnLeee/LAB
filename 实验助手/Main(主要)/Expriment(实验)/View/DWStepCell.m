//
//  DWStepCell.m
//  实验助手
//
//  Created by sxq on 15/9/25.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "MZTimerLabel.h"
#import "DWStepCell.h"
#import "PhotoContainer.h"
#import "SXQExpStep.h"
#import "PhotoContainer.h"
#import "SXQExpStepFrame.h"
static const CGFloat xPaddind = 8;
static const CGFloat yPadding =8;

@interface DWStepCell ()
@property (nonatomic,weak) UILabel *stepNumLabel;
@property (nonatomic,weak) UILabel *stepDescLabel;
@property (nonatomic,weak) UILabel *stepRemarkLabel;
@property (nonatomic,weak) UILabel *stepRemarkContentLabel;
@property (nonatomic,weak) PhotoContainer *photoView;
@property (nonatomic,weak) UILabel *timeLabel;
@property (nonatomic,strong) MZTimerLabel *mzLabel;
@end
@implementation DWStepCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSelf];
    }
    return self;
}
- (void)setupSelf
{
    self.layer.cornerRadius = 8;
    self.clipsToBounds = YES;
    UILabel *stepNumLabel = [[UILabel alloc] init];
    stepNumLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:stepNumLabel];
    _stepNumLabel = stepNumLabel;
    
    UILabel *stepDescLabel = [[UILabel alloc] init];
    stepDescLabel.font = [UIFont systemFontOfSize:15];
    stepDescLabel.numberOfLines = 0;
    [self.contentView addSubview:stepDescLabel];
    _stepDescLabel = stepDescLabel;
    
    UILabel *stepremarkLabel = [[UILabel alloc] init];
    stepremarkLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:stepremarkLabel];
    _stepRemarkLabel = stepremarkLabel;
    
    UILabel *stepRemarkContentLabel = [[UILabel alloc] init];
    stepRemarkContentLabel.numberOfLines = 0;
    stepRemarkContentLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:stepRemarkContentLabel];
    _stepRemarkContentLabel = stepRemarkContentLabel;
    
    PhotoContainer *photoView = [[PhotoContainer alloc] init];
    [self.contentView addSubview:photoView];
    _photoView = photoView;
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.textColor = [UIColor blackColor];
    timeLabel.text = @"00:00:00";
    _timeLabel = timeLabel;
    [self.contentView addSubview:timeLabel];
    
    _mzLabel = [[MZTimerLabel alloc] initWithLabel:_timeLabel andTimerType:MZTimerLabelTypeTimer];
//    [_mzLabel start];
}
- (void)setStepFrame:(SXQExpStepFrame *)stepFrame
{
    _stepFrame = stepFrame;
    SXQExpStep *expProcess = stepFrame.expStep;
    
    [self bindingTimer];
    _photoView.myImages = expProcess.images;
    if (expProcess.processMemo.length) {
        _stepRemarkLabel.hidden = NO;
        _stepRemarkLabel.text = @"备注";
    }else
    {
        _stepRemarkLabel.hidden = YES;
    }
    _stepNumLabel.text = [NSString stringWithFormat:@"步骤%d",expProcess.stepNum];
    _stepDescLabel.text = expProcess.expStepDesc;
    _stepRemarkContentLabel.text = expProcess.processMemo;
    [self.stepFrame.expStep addObserver:self forKeyPath:@"processMemo" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    [self.stepFrame.expStep addObserver:self forKeyPath:@"images" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld  context:nil];
}
- (void)bindingTimer
{
    SXQExpStep *expstep = self.stepFrame.expStep;
    _mzLabel.delegate = expstep;
    
    NSTimeInterval time = [expstep.expStepTime doubleValue] * 60;
    [_mzLabel setCountDownTime:time];
    [RACObserve(expstep, isUserTimer)
     subscribeNext:^(NSNumber *isUseTimer) {
         if ([isUseTimer boolValue]) {
             [_mzLabel start];
         }else
         {
             [_mzLabel pause];
         }
    }];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    _stepRemarkContentLabel.text = self.stepFrame.expStep.processMemo;
    _photoView.myImages = self.stepFrame.expStep.images;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"needreloadCell" object:self];
}
- (void)dealloc
{
    [self.stepFrame.expStep removeObserver:self forKeyPath:@"processMemo"];
    [self.stepFrame.expStep removeObserver:self forKeyPath:@"images"];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    _stepNumLabel.frame = _stepFrame.stepNumFrame;
    _stepDescLabel.frame = _stepFrame.stepDescFrame;
    _stepRemarkLabel.frame = _stepFrame.remarkFrame;
    _stepRemarkContentLabel.frame = _stepFrame.remarkContentFrame;
    _photoView.frame = _stepFrame.photosFrame;
    _timeLabel.frame = _stepFrame.timeLabelFrame;
}
- (void)setFrame:(CGRect)frame
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    frame.origin.y += yPadding;
    frame.origin.x = xPaddind;
    frame.size.width = screenSize.width - 2 * xPaddind;
    frame.size.height -= yPadding;
    [super setFrame:frame];
}
-(void)setSelected:(BOOL)selected
{
    
}
@end
