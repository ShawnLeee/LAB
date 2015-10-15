//
//  SXQConsumableMap.h
//  实验助手
//
//  Created by sxq on 15/10/15.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXQConsumableMap : NSObject
@property (nonatomic,copy) NSString *consumableID;
@property (nonatomic,copy) NSString *consumableMapID;
@property (nonatomic,assign) BOOL isSuggestion;
@property (nonatomic,copy) NSString *supplierID;
@end
