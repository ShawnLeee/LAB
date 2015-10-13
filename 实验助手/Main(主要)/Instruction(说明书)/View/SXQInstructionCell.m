//
//  SXQInstructionCell.m
//  实验助手
//
//  Created by sxq on 15/9/16.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
#import "SXQExpSubCategory.h"
#import "SXQInstructionCell.h"

@implementation SXQInstructionCell
- (void)configureCellWithItem:(SXQExpSubCategory *)item
{
    _instructionNameLabel.text = item.expSubCategoryName;
}
- (void)awakeFromNib {
    // Initialization code
}

@end
