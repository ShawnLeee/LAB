//
//  SXQReagentCell.h
//  实验助手
//
//  Created by sxq on 15/9/30.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <UIKit/UIKit.h>
@class SXQReagentCell;
@protocol SXQReagentCellDelegate <NSObject>
@optional
- (void)reagentCell:(SXQReagentCell *)reagentCell clickedSupplierButton:(UIButton *)button;
@end
@interface SXQReagentCell : UITableViewCell
- (void)configureCellWithItem:(id)item;
@property (nonatomic,weak) id<SXQReagentCellDelegate> delegate;
@end

