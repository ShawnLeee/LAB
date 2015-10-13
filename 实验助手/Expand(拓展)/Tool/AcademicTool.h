//
//  AcademicTool.h
//  实验助手
//
//  Created by sxq on 15/9/15.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
typedef void (^AdjacentUserCompletion)(NSArray *adjacentUsers);

@interface AcademicTool : NSObject
+ (void)fetchAdjacentUserDataWithCurrentLocation:(CLLocationCoordinate2D)currentLocationCoordinate completion:(AdjacentUserCompletion)completion;
@end


@interface AdjacentUserParam : NSObject
@property (nonatomic,copy) NSString *userID;
@property (nonatomic,copy) NSString *longitude;
@property (nonatomic,copy) NSString *latitude;
+ (instancetype)paramWithCoordiante:(CLLocationCoordinate2D)coordinate;
@end