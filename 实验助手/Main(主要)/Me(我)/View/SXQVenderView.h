//
//  SXQVenderView.h
//  实验助手
//
//  Created by sxq on 15/9/11.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
@class SXQVenderView;
#import <UIKit/UIKit.h>
@protocol SXQVenderViewDelegate <NSObject>
@optional
- (void)clickedVenderView:(SXQVenderView *)view;
@end

@interface SXQVenderView : UIView
@property (strong, nonatomic) IBOutlet UIView *view;
- (void)setupViewWithImage:(NSString *)image title:(NSString *)title delegate:(id<SXQVenderViewDelegate>)delegate tag:(NSUInteger)tag;
@property (nonatomic,weak) id<SXQVenderViewDelegate> delegate;
@end
