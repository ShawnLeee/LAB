//
//  ArrayDataSource.h
//  SXQMovie
//
//  Created by SXQ on 15/8/11.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void (^CellConfigureBlock)(id cell,id item);

@interface ArrayDataSource : NSObject

@property (nonatomic,strong) NSArray *items;
@property (nonatomic,copy) NSString *cellIdentifier;
@property (nonatomic,copy) CellConfigureBlock configureBlock;
@property (nonatomic,assign,getter=isGroupArray) BOOL groupArray;

- (instancetype)initWithItems:(NSArray *)anItems
               cellIdentifier:(NSString *)aCellIdentifier
           cellConfigureBlock:(CellConfigureBlock )aConfigureBlock;

- (instancetype)initWithGroups:(NSArray *)groups;

- (instancetype)itemAtIndexPath:(NSIndexPath *)indexPath;
@end
