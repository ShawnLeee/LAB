//
//  SXQReagentListData.m
//  实验助手
//
//  Created by sxq on 15/9/30.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "SXQReagentListData.h"
#import "InstructionTool.h"
@interface SXQReagentListData ()
@property (nonatomic,strong,readwrite) NSArray *reagents;
@property (nonatomic,copy) void (^completionBlk)();
@property (nonatomic,copy) NSString *expId;
@end
@implementation SXQReagentListData
- (instancetype)initWithExpInstructionID:(NSString *)expID DataLoadComletedBlock:(void (^)())completionBlk
{
    if (self = [super init]) {
        _completionBlk = completionBlk;
        _expId = expID;
    }
    return self;
}
- (NSArray *)reagents
{
    if (_reagents == nil) {
        //load the data
        [InstructionTool fetchExpReagentWithExpInstructionID:_expId success:^(ReagentListResult *result) {
            _reagents = result.data;
            _completionBlk();
        } failure:^(NSError *errror) {
            
        }];
    }
    return _reagents;
}
@end
