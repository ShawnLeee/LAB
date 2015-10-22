//
//  SXQLoginViewModelServiceImpl.m
//  实验助手
//
//  Created by sxq on 15/10/22.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQLoginImpl.h"
#import "SXQLoginViewModelServiceImpl.h"
@interface SXQLoginViewModelServiceImpl ()
@property (nonatomic,strong) SXQLoginImpl *service;
@end

@implementation SXQLoginViewModelServiceImpl
- (instancetype)init
{
    if (self = [super init]) {
        _service = [[SXQLoginImpl alloc] init];
    }
    return self;
}
- (id<SXQLogin>)getService
{
    return _service;
}
@end
