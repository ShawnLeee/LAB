//
//  SXQAdjacentUser.m
//  实验助手
//
//  Created by sxq on 15/9/15.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//

#import "SXQAdjacentUser.h"

@implementation SXQAdjacentUser
- (CLLocationCoordinate2D)coordinate
{
    return  CLLocationCoordinate2DMake([_latitude doubleValue], [_longitude doubleValue]);
}
@end
