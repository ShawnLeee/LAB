//
//  SXQAnnotation.h
//  实验助手
//
//  Created by sxq on 15/9/14.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@class SXQAdjacentUser;
@interface SXQAnnotation : UIView<MKAnnotation>
// Center latitude and longitude of the annotation view.
// The implementation of this property must be KVO compliant.
@property (nonatomic) CLLocationCoordinate2D coordinate;

// Title and subtitle for use by selection UI.
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

// Called as a result of dragging an annotation view.
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate NS_AVAILABLE(10_9, 4_0);
//Convinient Method
+ (instancetype)annotationWithAdjacentUser:(SXQAdjacentUser *)adjacentUser;

@end
