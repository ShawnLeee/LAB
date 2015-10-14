//
//  SXQExpStep.h
//  实验助手
//
//  Created by sxq on 15/10/9.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
@interface SXQExpStep : NSObject
@property (nonatomic,copy) NSString  *expInstructionID;
@property (nonatomic,copy) NSString  *expStepDesc;
@property (nonatomic,copy) NSString  *expStepID;
@property (nonatomic,copy) NSString  *expStepTime;
@property (nonatomic,assign) int  stepNum;


@property (nonatomic,assign) BOOL isUserTimer;
@property (nonatomic,assign) BOOL isActiveStep;
@property (nonatomic,copy) NSString *processMemo;
@property (nonatomic,copy) NSString *myExpProcessId;



/**
 *  试剂保存位置
 */
@property (nonatomic,copy) NSString *depositReagent;

@property (nonatomic,strong) NSMutableArray *images;
@property (nonatomic,assign) CGFloat imageHeight;
- (void)saveProcessMemo:(NSString *)processMemo;
- (void)addImage:(UIImage *)image;
@end
