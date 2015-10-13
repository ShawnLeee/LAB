//
//  TimeRecorder.h
//  TimeMachine
//
//  Created by sxq on 15/9/21.
//  Copyright (c) 2015年 sxq. All rights reserved.
//
#import <UIKit/UIKit.h>
@class TimeRecorder;
@protocol TimeRecorderDelegate <NSObject>
@optional
- (void)timeRecorder:(TimeRecorder *)timeRecorder finishedTimerWithTime:(NSTimeInterval)countTime;
- (void)timeRecorderdidPaused:(TimeRecorder *)timeRecorder;
- (void)timeRecorderdidCancel:(TimeRecorder *)timeRecorder;
@end
@interface TimeRecorder : UIView


@property (strong, nonatomic) IBOutlet UIView *timeRecorderView;
@property (nonatomic,weak) id<TimeRecorderDelegate> delegate;
+ (instancetype)showTimer;
- (void)hideTimer;
- (void)startTimer;
- (void)pauseTimer;
- (void)resetTimer;
@end
