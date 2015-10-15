//
//  SXQConsumable.h
//  实验助手
//
//  Created by sxq on 15/10/15.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class SXQSupplier;
#import <Foundation/Foundation.h>

@interface SXQConsumable : NSObject
@property (nonatomic,copy) NSString *consumableID;
@property (nonatomic,copy) NSString *consumableName;
@property (nonatomic,copy) NSString *consumableType;

@property (nonatomic,strong) SXQSupplier *preferSupplier;
/**
 *  所有厂商
 */
@property (nonatomic,strong) NSArray *suppliers;
@end
