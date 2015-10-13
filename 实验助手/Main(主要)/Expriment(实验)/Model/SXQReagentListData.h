//
//  SXQReagentListData.h
//  实验助手
//
//  Created by sxq on 15/9/30.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXQReagentListData : NSObject
@property (nonatomic,strong,readonly) NSArray *reagents;
- (instancetype)initWithExpInstructionID:(NSString *)expID DataLoadComletedBlock:(void (^)())completionBlk;
@end
