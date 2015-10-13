//
//  SXQHotInstructionCell.m
//  实验助手
//
//  Created by sxq on 15/9/30.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQHotInstruction.h"
#import "SXQHotInstructionCell.h"
@interface SXQHotInstructionCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *uploadTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *downLoadCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *reviewLabel;
@property (weak, nonatomic) IBOutlet UIImageView *downLoadIcon;
@property (weak, nonatomic) IBOutlet UIImageView *reviewIcon;

@end
@implementation SXQHotInstructionCell
- (void)configureCellWithItem:(SXQHotInstruction *)item
{
    _nameLabel.text = item.experimentName;
    _uploadTimeLabel.text = [NSString stringWithFormat:@"%@前上传",item.nDaysAgo];
    _downLoadCountLabel.text = item.downloadCount;
    _reviewLabel.text = item.reviewCount;
}


@end
