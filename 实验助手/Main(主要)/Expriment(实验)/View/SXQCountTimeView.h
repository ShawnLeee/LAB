//
//  SXQCountTimeView.h
//  实验助手
//
//  Created by sxq on 15/10/21.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class RACSignal,SXQCountTimeView;
#import <UIKit/UIKit.h>
@protocol SXQCountTimeViewDelegate <NSObject>
- (void)countTimeView:(SXQCountTimeView *)timeView choosedTime:(NSTimeInterval)time;
@end

@interface SXQCountTimeView : UIView
@property (nonatomic,weak) id<SXQCountTimeViewDelegate> delegate;
- (void)show;
- (void)hide;
@end
