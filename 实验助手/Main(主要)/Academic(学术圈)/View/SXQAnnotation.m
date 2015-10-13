//
//  SXQAnnotation.m
//  实验助手
//
//  Created by sxq on 15/9/14.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
#import "SXQAnnotation.h"
#import "SXQAdjacentUser.h"
@implementation SXQAnnotation
+ (instancetype)annotationWithAdjacentUser:(SXQAdjacentUser *)adjacentUser
{
    SXQAnnotation *annotation = [SXQAnnotation new];
    annotation.coordinate = [adjacentUser coordinate];
    annotation.title = adjacentUser.reagentName;
    return annotation;
}

@end
