//
//  SXQReagentMap.h
//  实验助手
//
//  Created by sxq on 15/10/15.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXQReagentMap : NSObject
@property (nonatomic,assign) BOOL  isSuggestion;
@property (nonatomic,copy) NSString  *reagentID;
@property (nonatomic,copy) NSString  *reagentMapID;
@property (nonatomic,copy) NSString  *supplierID;
@end
