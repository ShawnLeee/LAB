//
//  SXQReagentContoller.m
//  实验助手
//
//  Created by sxq on 15/9/14.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
@import MapKit;
#import "SXQReagentContoller.h"
#import "SXQAnnotation.h"
#import "SXQAnnotationView.h"
#import "AcademicTool.h"
#import "SXQAdjacentUser.h"
@interface SXQReagentContoller ()<MKMapViewDelegate,CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end
@implementation SXQReagentContoller

- (void)viewDidLoad {
    [super viewDidLoad];
    _mapView.userTrackingMode = MKUserTrackingModeFollow;
    _mapView.mapType = MKMapTypeStandard;
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKPinAnnotationView *annotionView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"sss"];
    annotionView.pinColor = MKPinAnnotationColorGreen;
    annotionView.canShowCallout = YES;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    annotionView.rightCalloutAccessoryView = button;
    return annotionView;
    
}
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D currentLocation = userLocation.location.coordinate;
    [_mapView setCenterCoordinate:currentLocation animated:YES];
    MKCoordinateSpan span = MKCoordinateSpanMake(0.021321, 0.019366);
    MKCoordinateRegion region = MKCoordinateRegionMake(currentLocation, span);
    [_mapView setRegion:region];
    [self addAdjacentUserWithCurrentLocation:userLocation.coordinate];
}
//获取附近用户添加大头针
- (void)addAdjacentUserWithCurrentLocation:(CLLocationCoordinate2D)currentLocationCoordinate
{
    //获取附近用户的数据
    [AcademicTool fetchAdjacentUserDataWithCurrentLocation:currentLocationCoordinate completion:^(NSArray *adjacentUsers) {
        //添加数据到地图
        [adjacentUsers enumerateObjectsUsingBlock:^(SXQAdjacentUser *user, NSUInteger idx, BOOL *stop) {
            SXQAnnotation *annotation = [SXQAnnotation annotationWithAdjacentUser:user];
            [_mapView addAnnotation:annotation];
        }];
    }];
}

@end
