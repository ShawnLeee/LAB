//
//  SXQSupplierData.h
//  实验助手
//
//  Created by sxq on 15/10/15.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXQSupplierData : NSObject
@property (nonatomic,strong) NSArray *consumable;
@property (nonatomic,strong) NSArray *consumableMap;
@property (nonatomic,strong) NSArray *reagent;
@property (nonatomic,strong) NSArray *reagentMap;
@property (nonatomic,strong) NSArray *equipment;
@property (nonatomic,strong) NSArray *equipmentMap;

@property (nonatomic,strong) NSArray *supplier;
@end
