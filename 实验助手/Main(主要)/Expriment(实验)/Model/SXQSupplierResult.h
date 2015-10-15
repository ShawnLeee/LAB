//
//  SXQSupplierResult.h
//  实验助手
//
//  Created by sxq on 15/10/15.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class SXQSupplierData;
#import <Foundation/Foundation.h>

@interface SXQSupplierResult : NSObject
@property (nonatomic,copy) NSString *code;
@property (nonatomic,strong) SXQSupplierData *data;
@property (nonatomic,copy) NSString *msg;
@end
