//
//  SXQSupplierCell.m
//  实验助手
//
//  Created by sxq on 15/10/15.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "SXQSupplierCell.h"
#import "SXQExpReagent.h"
#import "SXQExpConsumable.h"
#import "SXQExpEquipment.h"
@interface SXQSupplierCell ()
@property (weak, nonatomic) IBOutlet UILabel *itemLabel;
@property (weak, nonatomic) IBOutlet UIButton *supplierBtn;

@end
@implementation SXQSupplierCell
- (void)configureCellWithItem:(id)item
{
    NSString *itemText = nil;
    if ([item isKindOfClass:[SXQExpReagent class]]) {
        SXQExpReagent *reagent = (SXQExpReagent *)item;
        itemText = reagent.reagentName;
        
    }else if([item isKindOfClass:[SXQExpConsumable class]])
    {
        SXQExpConsumable *consumble = (SXQExpConsumable *)item;
        itemText = consumble.consumableName;
    }else
    {
        SXQExpEquipment *equipment = (SXQExpEquipment *)item;
        itemText = equipment.equipmentName;
    }
    _itemLabel.text = itemText;
}
- (IBAction)supplierBtnClicked:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(supplierCell:clickedBtn:)]) {
        [_delegate supplierCell:self clickedBtn:sender];
    }
}
@end
