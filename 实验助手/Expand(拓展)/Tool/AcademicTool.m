//
//  AcademicTool.m
//  实验助手
//
//  Created by sxq on 15/9/15.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
#import "AcademicTool.h"
#import "SXQURL.h"
#import "SXQHttpTool.h"
#import "SXQAdjacentUser.h"
#import <MJExtension/MJExtension.h>
@implementation AcademicTool
+ (void)fetchAdjacentUserDataWithCurrentLocation:(CLLocationCoordinate2D)currentLocationCoordinate completion:(AdjacentUserCompletion)completion
{
    AdjacentUserParam *param = [AdjacentUserParam paramWithCoordiante:currentLocationCoordinate];
    param.userID = @"4028c681494b994701494b99aba50000";
    [SXQHttpTool getWithURL:AdjacentReagentURL params:param.keyValues success:^(id json) {
        NSArray *resultArr = [SXQAdjacentUser objectArrayWithKeyValuesArray:json[@"aroundUser"]];
        if (completion) {
            completion(resultArr);
        }
    } failure:^(NSError *error) {
        
    }];
}
@end

@implementation AdjacentUserParam
+ (instancetype)paramWithCoordiante:(CLLocationCoordinate2D)coordinate
{
    AdjacentUserParam *param = [AdjacentUserParam new];
    param.latitude = [NSString stringWithFormat:@"%f",coordinate.latitude];
    param.longitude = [NSString stringWithFormat:@"%f",coordinate.longitude];
    return param;
}
@end