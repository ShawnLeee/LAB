//
//  SXQLoginViewModelService.h
//  实验助手
//
//  Created by sxq on 15/10/22.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQLogin.h"
#import <Foundation/Foundation.h>

@protocol SXQLoginViewModelService <NSObject>
- (id<SXQLogin>)getService;
@end
