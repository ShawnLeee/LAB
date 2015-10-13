//
//  SXQMenuCell.m
//  实验助手
//
//  Created by sxq on 15/9/16.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
#import "SXQColor.h"
#import "SXQMenuCell.h"
#import "SXQExpCategory.h"
@implementation SXQMenuCell
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
    }
    return self;
}
- (void)awakeFromNib {
    UIView *bgView = [UIView new];
    bgView.backgroundColor = MenuCellBgColor;
    self.backgroundView = bgView;
    UIView *selectedBgView = [UIView new];
    selectedBgView.backgroundColor = MenuCellSelectedBgColor;
    self.selectedBackgroundView = selectedBgView;
    self.itemTitle.textColor = MenuCellTitleColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configureCellWithItem:(SXQExpCategory *)item
{
    self.itemTitle.text = item.expCategoryName;
}
@end
