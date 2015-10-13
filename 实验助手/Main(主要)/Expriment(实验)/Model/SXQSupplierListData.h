//
//  SXQSupplierListData.h
//  实验助手
//
//  Created by sxq on 15/9/30.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXQSupplierListData : NSObject
@property (nonatomic,strong) NSArray *suppliers;
- (instancetype)initWithReagentID:(NSString *)reagentID dataLoadedComplete:(void (^)(BOOL success))completion;
@end
