//
//  SXQListCell.h
//  实验助手
//
//  Created by sxq on 15/9/1.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class SXQListCell;
#import <UIKit/UIKit.h>
@protocol SXQListCellDelegate <NSObject>

@optional
- (void)listCell:(SXQListCell *)cell clickedDownloadBtn:(UIButton *)button;

@end

@interface SXQListCell : UITableViewCell
- (void)configureCellWithItem:(id)item;
@property (nonatomic,assign,getter=idDownloaded) BOOL downloaded;
@property (nonatomic,weak) id<SXQListCellDelegate> delegate;
@end
