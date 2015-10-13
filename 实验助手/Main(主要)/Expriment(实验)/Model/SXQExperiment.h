//
//  SXQExperiment.h
//  实验助手
//
//  Created by sxq on 15/9/21.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXQExperiment : NSObject
/**
 *  实验名称
 */
@property (nonatomic,copy) NSString *experimentName;
/**
 *  实验步骤
 */
@property (nonatomic,strong) NSArray *steps;
@end
