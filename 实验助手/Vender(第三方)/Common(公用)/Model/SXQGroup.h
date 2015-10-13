//
//  SXQGroup.h
//  实验助手
//
//  Created by SXQ on 15/8/30.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXQGroup : NSObject
@property (nonatomic,copy,readonly) NSString *groupTitle;
@property (nonatomic,strong,readonly) NSArray *items;

+ (instancetype)groupWithGroupTitle:(NSString *)groupTitle items:(NSArray *)items;
@end
