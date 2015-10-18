//
//  SXQExperimentToolBar.h
//  实验助手
//
//  Created by sxq on 15/9/15.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
@class SXQExpStep;
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, ExperimentTooBarButtonType)
{
    ExperimentTooBarButtonTypeStart = 0,
    ExperimentTooBarButtonTypeBack = 1,
    ExperimentTooBarButtonTypeRemark = 2,
    ExperimentTooBarButtonTypeReport = 3,
    ExperimentTooBarButtonTypePhoto = 4,
};
@class SXQExperimentToolBar;
@protocol SXQExperimentToolBarDelegate <NSObject>
@optional
- (void)experimentToolBar:(SXQExperimentToolBar *)toolBar clickButtonWithType:(ExperimentTooBarButtonType)buttonType;
@end

@interface SXQExperimentToolBar : UIView
@property (weak, nonatomic) IBOutlet UIButton *starBtn;
@property (nonatomic,strong) SXQExpStep *currentStep;
@property (nonatomic,weak) id<SXQExperimentToolBarDelegate> delegate;
@end
