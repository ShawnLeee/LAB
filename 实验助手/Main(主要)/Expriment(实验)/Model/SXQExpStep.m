//
//  SXQExpStep.m
//  实验助手
//
//  Created by sxq on 15/10/9.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQDBManager.h"
#import "SXQExpStep.h"
static const NSUInteger kImageCount = 9;
@interface SXQExpStep ()
@property (nonatomic,strong,readwrite) NSMutableArray *images;
@end
@implementation SXQExpStep
- (NSString *)processMemo
{
    if ([_processMemo isEqualToString:@"(null)"]) {
        return @"";
    }
    return _processMemo;
}
- (void)saveProcessMemo:(NSString *)processMemo
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        _processMemo = [processMemo copy];
        [[SXQDBManager sharedManager] updateMyExpProcessMemoWithExpProcessID:_myExpProcessId
                                                                 processMemo:_processMemo];
    });
}
- (void)addImage:(UIImage *)image
{
    if (self.images.count < kImageCount)
        [self.images addObject:image];
}
@end
