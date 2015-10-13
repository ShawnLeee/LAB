//
//  InstructionTool.m
//  实验助手
//
//  Created by sxq on 15/9/21.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
#import "SXQInstructionDownloadResult.h"
#import "SXQHttpTool.h"
#import "SXQURL.h"
#import <MJExtension/MJExtension.h>
#import "InstructionTool.h"
#import "SXQExpCategory.h"
#import "SXQHotInstruction.h"
#import "SXQExpSubCategory.h"
#import "SXQExpInstruction.h"
#import "SXQExpReagent.h"
#import "SXQDBManager.h"
@implementation InstructionTool
+ (void)fetchAllExpSuccess:(void (^)(ExpCategoryResult *))success failure:(void (^)(NSError *))failure
{
    [SXQHttpTool getWithURL:AllExpURL params:nil success:^(id json) {
        if (success) {
            ExpCategoryResult *result = [ExpCategoryResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}
+ (void)fetchSubCategoryWithCategoryId:(NSString *)categoryID success:(void (^)(ExpSubCategoryResult *))success failure:(void (^)(NSError *))failure
{
    NSDictionary *param = @{@"expCategoryID" : categoryID};
    [SXQHttpTool getWithURL:SubExpURL params:param success:^(id json) {
        if (success) {
            ExpSubCategoryResult *result = [ExpSubCategoryResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+ (void)fetchInstructionLishWithExpSubCategoryID:(NSString *)subID success:(void (^)(ExpInstructionsResult *))success failure:(void (^)(NSError *))failure
{
    NSDictionary *param = @{@"expSubCategoryID" : subID};
    [SXQHttpTool getWithURL:InstructionListURL params:param success:^(id json) {
        if (success) {
            ExpInstructionsResult *result = [ExpInstructionsResult objectWithKeyValues:json];
            [result.data enumerateObjectsUsingBlock:^(SXQExpInstruction *instrution, NSUInteger idx, BOOL * _Nonnull stop) {
                instrution.downloaded = [[SXQDBManager sharedManager] expInstrucitonExist:instrution.expInstructionID];
            }];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+ (void)downloadInstructionWithID:(NSString *)instructionID success:(void (^)(SXQInstructionDownloadResult *))success failure:(void (^)(NSError *))failure
{
    NSDictionary *params = @{@"expInstructionID" : instructionID};
    [SXQHttpTool getWithURL:DownloadInstructionURL params:params success:^(id json) {
        if(success)
        {
            SXQInstructionDownloadResult *result = [SXQInstructionDownloadResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        
    }];
}
+ (void)fetchInstructionDetailWithParam:(InstructionDetailParam *)param success:(void (^)(InstructionDetailResult *))success failure:(void (^)(NSError *))failure
{
    [SXQHttpTool getWithURL:InstructionDetailURL params:param.keyValues success:^(id json) {
        if (success) {
            InstructionDetailResult *result = [InstructionDetailResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+ (void)fetchHotInstructionsSuccess:(void (^)(HotInstructionResult *))success failure:(void (^)(NSError *))failure
{
    NSDictionary *param = @{@"returnLimit" :@10};
    [SXQHttpTool getWithURL:HotInstructionsURL params:param.keyValues success:^(id json) {
        if (success) {
            HotInstructionResult *result = [HotInstructionResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+ (void)fetchExpReagentWithExpInstructionID:(NSString *)expInstructionID success:(void (^)(ReagentListResult *))success failure:(void (^)(NSError *))failure
{
    NSDictionary *param = @{@"expInstructionID" : expInstructionID};
    [SXQHttpTool getWithURL:ReagentListURL params:param success:^(id json) {
        if (success) {
            ReagentListResult *result = [ReagentListResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end

@implementation ExpCategoryResult
+ (NSDictionary *)objectClassInArray
{
    return @{@"data" : [SXQExpCategory class]};
}
@end

@implementation ExpSubCategoryResult
+ (NSDictionary *)objectClassInArray
{
    return @{@"data" : [SXQExpSubCategory class]};
}
@end

@implementation ExpInstructionsResult
+ (NSDictionary *)objectClassInArray
{
    return @{@"data" : [SXQExpInstruction class]};
}
@end

@implementation InstructionDetailParam
@end

@implementation InstructionDetailResult
@end

@implementation HotInstructionResult
+ (NSDictionary *)objectClassInArray
{
    return @{@"data" : [SXQHotInstruction class]};
}
@end

@implementation ReagentListResult
+ (NSDictionary *)objectClassInArray
{
    return @{@"data" : [SXQExpReagent class]};
}
@end
