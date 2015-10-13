//
//  SXQMyExperiment.h
//  实验助手
//
//  Created by sxq on 15/10/12.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXQMyExperiment : NSObject
@property (nonatomic,copy) NSString *myExpId;
@property (nonatomic,copy) NSString *expInstructionId;
@property (nonatomic,copy) NSString *userId;
@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,copy) NSString *finishTime;
@property (nonatomic,assign) BOOL isReviewed;
@property (nonatomic,assign) BOOL isCreateReport;
@property (nonatomic,assign) BOOL isUpload;
@property (nonatomic,copy) NSString *reportName;
@property (nonatomic,copy) NSString *reportLocation;
@property (nonatomic,copy) NSString *reportServerPath;
@property (nonatomic,assign) int expState;
@property (nonatomic,copy) NSString *expMemo;
@end
