//
//  SXQSupplierListData.m
//  实验助手
//
//  Created by sxq on 15/9/30.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "SXQSupplierListData.h"
#import "SXQDBManager.h"
@interface SXQSupplierListData ()
@end
@implementation SXQSupplierListData
- (instancetype)initWithReagentID:(NSString *)reagentID dataLoadedComplete:(void (^)(BOOL))completion
{
    if (self = [super init]) {
        _suppliers = @[];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            if ([self loadDataWithReagentID:reagentID]) {
                completion(YES);
            }
            
        });
    }
    return self;
}
- (BOOL)loadDataWithReagentID:(NSString *)reagentID
{
    _suppliers = [[SXQDBManager sharedManager] querySupplierWithReagetID:reagentID];
    return _suppliers ? YES : NO;
}
@end
