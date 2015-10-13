//
//  SXQGroupCell.h
//  实验助手
//
//  Created by SXQ on 15/8/30.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//

@class SXQGroupCell;
#import <UIKit/UIKit.h>

@protocol SXQGroupCellDelegate <NSObject>
@optional
- (void)groupCell:(SXQGroupCell *)cell selectedItem:(id)item;

@end
//**////////
@interface SXQGroupCell : UITableViewCell
@property (nonatomic,strong) NSArray *items;
@property (nonatomic,weak) id<SXQGroupCellDelegate> delegate;
@end
