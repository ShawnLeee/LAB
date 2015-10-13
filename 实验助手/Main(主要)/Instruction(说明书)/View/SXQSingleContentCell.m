//
//  SXQSingleContentCell.m
//  实验助手
//
//  Created by sxq on 15/9/23.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "SXQSingleContentCell.h"
@interface SXQSingleContentCell ()
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
@implementation SXQSingleContentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configureCellWithItem:(NSString *)item
{
    _contentLabel.text = item;
}
@end
