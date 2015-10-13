//
//  SXQGroup.m
//  实验助手
//
//  Created by SXQ on 15/8/30.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//

#import "SXQGroup.h"
@interface SXQGroup ()
@property (nonatomic,copy,readwrite) NSString *groupTitle;
@property (nonatomic,strong,readwrite) NSArray *items;
@end
@implementation SXQGroup


+ (instancetype)groupWithGroupTitle:(NSString *)groupTitle items:(NSArray *)items
{
    SXQGroup *group = [SXQGroup new];
    group.groupTitle = groupTitle;
    group.items = items;
    return group;
}
@end
