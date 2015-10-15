//
//  SXQReagent.h
//  实验助手
//
//  Created by sxq on 15/10/15.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class SXQSupplier;
#import <Foundation/Foundation.h>

@interface SXQReagent : NSObject
@property (nonatomic,copy) NSString *agents;
@property (nonatomic,copy) NSString *arrivalDate;
@property (nonatomic,copy) NSString *casNo;
@property (nonatomic,copy) NSString *chemicalName;
@property (nonatomic,copy) NSString *levelOneSortID;
@property (nonatomic,copy) NSString *levelTwoSortID;
@property (nonatomic,copy) NSString *memo;
@property (nonatomic,copy) NSString *originPlace;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *productNo;
@property (nonatomic,copy) NSString *reagentCommonName;
@property (nonatomic,copy) NSString *reagentID;
@property (nonatomic,copy) NSString *reagentName;
@property (nonatomic,copy) NSString *specification;


/**
 *  建议厂商
 */
@property (nonatomic,strong) SXQSupplier *preferSupplier;
/**
 *  所有厂商
 */
@property (nonatomic,strong) NSArray *suppliers;
@end
