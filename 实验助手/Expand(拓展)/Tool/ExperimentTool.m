//
//  ExperimentTool.m
//  实验助手
//
//  Created by sxq on 15/9/16.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
#import "SXQSupplierData.h"
#import "SXQSupplierResult.h"
#import "SXQHttpTool.h"
#import "SXQURL.h"
#import "ExperimentTool.h"
#import <MJExtension/MJExtension.h>
#import "SXQExperimentModel.h"
#import "SXQExperimentStep.h"
#import <MJExtension/MJExtension.h>
#import "SXQExperimentResult.h"
#import "SXQExperimentStepResult.h"
@implementation ExperimentTool

+ (void)fetchDoingExperimentWithParam:(id)param success:(void (^)(SXQExperimentResult *result))success failure:(void (^)(NSError *error))failure
{
    [SXQHttpTool getWithURL:DoingExpURL params:param success:^(id json) {
        if (success) {
            SXQExperimentResult *result = [SXQExperimentResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)fetchDoneExperimentWithParam:(id)param completion:(CompletionBlock)completion
{
    [SXQHttpTool getWithURL:DoneExpURL params:param success:^(id json) {
        if (completion) {
            NSArray *resultArr = [SXQExperimentModel objectArrayWithKeyValuesArray:json[@"data"]];
            completion(resultArr);
        }
    } failure:^(NSError *error) {
        
    }];
}
+ (void)fetchExperimentStepWithParam:(ExperimentParam *)param success:(void (^)(SXQExperimentStepResult *))success failure:(void (^)(NSError *))failure
{
    [SXQHttpTool getWithURL:ExperimentStepURL params:param.keyValues success:^(id json) {
        
        if (success) {
            SXQExperimentStepResult *result = [SXQExperimentStepResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+ (void)fetchSupplierWithReagentID:(NSString *)reagentID success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    
}
+ (void)loadSupplierDataSuccess:(void (^)(SXQSupplierData *))success failure:(void (^)(NSError *))failure
{
    [SXQHttpTool getWithURL:SupplierURL params:nil success:^(id json) {
        if (success) {
            SXQSupplierResult *result = [SXQSupplierResult objectWithKeyValues:json];
            SXQSupplierData *supplierData = result.data;
            success(supplierData);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
}
@end
@implementation ExperimentParam
+ (instancetype)paramWithExperimentModel:(SXQExperimentModel *)experimentModel
{
    ExperimentParam *param = [[ExperimentParam alloc] init];
    param.myExpID = experimentModel.myExpID;
    param.expState = experimentModel.expState;
    param.expInstructionID = experimentModel.expInstructionID;
    return param;
}
@end