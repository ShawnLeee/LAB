//
//  SXQGroup.h
//  实验助手
//
//  Created by sxq on 15/9/14.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//

typedef void (^CellConfigureBlock)(id cell,id item);
#import <Foundation/Foundation.h>

@interface DWGroup : NSObject
/**
 * ConfigureBlock For Given Group
 */
@property (nonatomic,copy) CellConfigureBlock configureBlk;
/**
 *  Section Header Title
 */
@property (nonatomic,copy) NSString *headerTitle;
/**
 *  Section Footer Title
 */
@property (nonatomic,copy) NSString *footerTitle;
/**
 *  data Array
 */
@property (nonatomic,strong) NSArray *items;
/**
 *  Cell Identifier for the given group
 */
@property (nonatomic,copy) NSString *identifier;
/**
 *  Designted Method
 *
 */
- (instancetype)initWithWithHeader:(NSString *)headerTitle
                         footer:(NSString *)footerTitle
                          items:(NSArray *)items;
/**
 *  Convinent Method
 */
+ (instancetype)groupWithItems:(NSArray *)items;

+ (instancetype)groupWithItems:(NSArray *)items identifier:(NSString *)identifier header:(NSString *)headerTitle;
+ (instancetype)groupWithItems:(NSArray *)items identifier:(NSString *)identifier header:(NSString *)headerTitle configureBlk:(CellConfigureBlock)cellConfigureBlk;
@end
