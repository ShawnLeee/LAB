//
//  SXQAdjacentUser.h
//  实验助手
//
//  Created by sxq on 15/9/15.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface SXQAdjacentUser : NSObject
@property (nonatomic,copy) NSString *mapID;
@property (nonatomic,copy) NSString *distance;
@property (nonatomic,copy) NSString *userID;
@property (nonatomic,copy) NSString *longitude;
@property (nonatomic,copy) NSString *latitude;
@property (nonatomic,copy) NSString *reagentName;
- (CLLocationCoordinate2D)coordinate;
@end
//{
//    "mapID" : "2c9283f54fcf29b3014fcf29cfdd0000",
//    "distance" : 65,
//    "userID" : "2c9283f54fcf29b3014fcf2a3f530001",
//    "longitude" : "121.43760323516177",
//    "latitude" : "31.18471009979488",
//    "reagentName" : "洗涤液"
//}