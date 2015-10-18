//
//  SXQExpStepFrame.h
//  实验助手
//
//  Created by sxq on 15/10/14.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class SXQExpStep;
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
@interface SXQExpStepFrame : NSObject
@property (nonatomic,strong) SXQExpStep *expStep;
@property (nonatomic,assign) CGRect stepNumFrame;
@property (nonatomic,assign) CGRect stepDescFrame;
@property (nonatomic,assign) CGRect remarkFrame;
@property (nonatomic,assign) CGRect remarkContentFrame;
@property (nonatomic,assign) CGRect photosFrame;
@property (nonatomic,assign) CGRect timeLabelFrame;
@property (nonatomic,assign) CGFloat cellHeight;
@end
