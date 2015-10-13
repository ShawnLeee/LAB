//
//  ArrayDataSource.m
//  SXQMovie
//
//  Created by SXQ on 15/8/11.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
#import "DWGroup.h"
#import "ArrayDataSource.h"
@interface ArrayDataSource ()

@end
@implementation ArrayDataSource
- (id)init
{
    return nil;
}
- (instancetype)initWithItems:(NSArray *)anItems cellIdentifier:(NSString *)aCellIdentifier cellConfigureBlock:(CellConfigureBlock)aConfigureBlock
{
    self = [super init];
    if (self) {
        _items = anItems;
        _cellIdentifier = aCellIdentifier;
        _configureBlock = aConfigureBlock;
        _groupArray = NO;
        
    }
    return self;
}
- (instancetype)initWithGroups:(NSArray *)groups
{
    if (self = [super init]) {
        _items = groups;
        _groupArray = YES;
    }
    return self;
}
- (instancetype)itemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.isGroupArray) {
        return self.items[indexPath.row];
    }else
    {
        DWGroup *group = _items[indexPath.section];
        return group.items[indexPath.row];
    }
    
}
@end
