//
//  ExperimentTool.h
//  实验助手
//
//  Created by sxq on 15/9/16.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
@class SXQExperimentModel,SXQExperimentStep,SXQExperimentResult,SXQExperimentStepResult,SXQSupplierData;
#import <Foundation/Foundation.h>

typedef void (^CompletionBlock)(NSArray *resultArray);

@interface ExperimentParam : NSObject
@property (nonatomic,copy) NSString *userID;
@property (nonatomic,copy) NSString *myExpID;
@property (nonatomic,copy) NSString *expInstructionID;
@property (nonatomic,assign) int expState;
+ (instancetype)paramWithExperimentModel:(SXQExperimentModel *)model;
@end


@interface ExperimentTool : NSObject
/**
 *  获取已完成的实验列表
 *
 *  @param completion 获取成功后的回调
 */
+ (void)fetchDoneExperimentWithParam:(id)param completion:(CompletionBlock)completion;
/**
 *  获取进行中的实验列表
 *
 *  @param completion 获取成功后的回调
 */
+ (void)fetchDoingExperimentWithParam:(id)param success:(void (^)(SXQExperimentResult *result))success failure:(void (^)(NSError *error))failure;
/**
 *  获取实验或说明书下所有的实验步骤
 */
+ (void)fetchExperimentStepWithParam:(ExperimentParam *)param success:(void (^)(SXQExperimentStepResult *result ))success failure:(void (^)(NSError *error))failure;
/**
 *  根据试剂ID取出供应商列表
 *
 *  @param reagentID  试剂ID
 *  @param success  [SXQSupplier]
 */
+ (void)fetchSupplierWithReagentID:(NSString *)reagentID success:(void (^)(NSArray *supplierList))success failure:(void (^)(NSError *error))failure;

+ (void)loadSupplierDataSuccess:(void (^)(SXQSupplierData *result))success failure:(void (^)(NSError *error))failure;
@end
