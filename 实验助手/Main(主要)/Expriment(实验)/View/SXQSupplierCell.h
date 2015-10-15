//
//  SXQSupplierCell.h
//  实验助手
//
//  Created by sxq on 15/10/15.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class SXQSupplierCell;
#import <UIKit/UIKit.h>
@protocol SXQSupplierDelegate <NSObject>
@optional
- (void)supplierCell:(SXQSupplierCell *)cell clickedBtn:(UIButton *)button;

@end
@interface SXQSupplierCell : UITableViewCell
- (void)configureCellWithItem:(id)item;

@property (nonatomic,weak) id<SXQSupplierDelegate> delegate;
@end
