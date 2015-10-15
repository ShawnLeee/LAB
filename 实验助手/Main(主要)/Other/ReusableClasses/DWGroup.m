//
//  SXQGroup.m
//  实验助手
//
//  Created by sxq on 15/9/14.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//

#import "DWGroup.h"
@interface DWGroup ()
@end
@implementation DWGroup
-  (instancetype)initWithWithHeader:(NSString *)headerTitle footer:(NSString *)footerTitle items:(NSArray *)items
{
    if (self = [super init]) {
        _headerTitle = headerTitle;
        _footerTitle = footerTitle;
        _items = items;
    }
    return self;
}
+ (instancetype)groupWithItems:(NSArray *)items
{
    return [[DWGroup alloc] initWithWithHeader:nil footer:nil items:items];
}
+ (instancetype)groupWithItems:(NSArray *)items identifier:(NSString *)identifier header:(NSString *)headerTitle
{
    DWGroup *group = [[DWGroup alloc] initWithWithHeader:headerTitle footer:nil items:items];
    group.identifier = identifier;
    return group;
}
+ (instancetype)groupWithItems:(NSArray *)items identifier:(NSString *)identifier header:(NSString *)headerTitle configureBlk:(CellConfigureBlock)cellConfigureBlk
{
    DWGroup *group = [self groupWithItems:items identifier:identifier header:headerTitle];
    group.configureBlk = [cellConfigureBlk copy];
    return group;
}
@end
