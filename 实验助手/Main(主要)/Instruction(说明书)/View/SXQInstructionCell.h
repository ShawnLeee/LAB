//
//  SXQInstructionCell.h
//  实验助手
//
//  Created by sxq on 15/9/16.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SXQInstructionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *instructionNameLabel;
- (void)configureCellWithItem:(id)item;
@end
