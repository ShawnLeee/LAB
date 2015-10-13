//
//  SXQExperimentStep.m
//  实验助手
//
//  Created by sxq on 15/9/18.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//

#import "SXQExperimentStep.h"
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
@interface SXQExperimentStep ()
@property (nonatomic,strong) NSMutableArray *theMutableArray;
@property (nonatomic,strong,readwrite) NSMutableArray *images;
@end
@implementation SXQExperimentStep
- (NSMutableArray *)images
{
    if (_images == nil) {
        _images = [NSMutableArray array];
    }
    return _images;
}
- (void)addImage:(UIImage *)image
{
    [self.images addObject:image];
}
@end
