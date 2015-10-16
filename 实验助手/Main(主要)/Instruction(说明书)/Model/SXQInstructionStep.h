//
//  SXQInstructionStep.h
//  实验助手
//
//  Created by sxq on 15/9/23.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXQInstructionStep : NSObject
@property (nonatomic,copy) NSString *expInstructionID;
@property (nonatomic,copy) NSString *expStepDesc;
@property (nonatomic,copy) NSString *expStepID;
@property (nonatomic,copy) NSString *expStepTime;
@property (nonatomic,assign) int stepNum;
@end
