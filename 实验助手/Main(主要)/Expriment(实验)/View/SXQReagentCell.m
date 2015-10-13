//
//  SXQReagentCell.m
//  实验助手
//
//  Created by sxq on 15/9/30.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQExpReagent.h"
#import "SXQReagentCell.h"
@interface SXQReagentCell ()
@property (weak, nonatomic) IBOutlet UILabel *reagentLabel;
@property (weak, nonatomic) IBOutlet UIButton *chooseSupplierBtn;

@end
@implementation SXQReagentCell
- (void)configureCellWithItem:(SXQExpReagent *)reagent
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _reagentLabel.text = reagent.reagentName;
}
- (IBAction)clickedChoosedBtn:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(reagentCell:clickedSupplierButton:)]) {
        [_delegate reagentCell:self clickedSupplierButton:sender];
    }
}
@end
