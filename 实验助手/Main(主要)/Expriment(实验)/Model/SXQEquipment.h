//
//  SXQEquipment.h
//  实验助手
//
//  Created by sxq on 15/10/15.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class SXQSupplier;
#import <Foundation/Foundation.h>

@interface SXQEquipment : NSObject
@property (nonatomic,copy) NSString *equipmentID;
@property (nonatomic,copy) NSString *equipmentName;

/**
 *  建议厂商
 */
@property (nonatomic,strong) SXQSupplier *preferSupplier;
/**
 *  所有厂商
 */
@property (nonatomic,strong) NSArray *suppliers;
@end
