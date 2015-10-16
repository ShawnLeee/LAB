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
#import "SXQSupplier.h"
#import "SXQExpEquipment.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#define kDefaultBtnTitle @"选择厂商"
@interface SXQSupplierCell ()
@property (weak, nonatomic) IBOutlet UILabel *itemLabel;
@property (weak, nonatomic) IBOutlet UIButton *supplierBtn;

@end
@implementation SXQSupplierCell
- (void)configureCellWithItem:(id)item
{
    if ([item isKindOfClass:[SXQExpReagent class]]) {
        SXQExpReagent *reagent = (SXQExpReagent *)item;
        if (reagent.preferSupplier) {
            [_supplierBtn setTitle:reagent.preferSupplier.supplierName forState:UIControlStateNormal];
        }else
        {
            [_supplierBtn setTitle:kDefaultBtnTitle forState:UIControlStateNormal];
        }
        [RACObserve(reagent, reagentName)
            subscribeNext:^(NSString *reagentName) {
                _itemLabel.text = reagentName;
        }];
        [[RACObserve(reagent, finalSupplier)
          
            filter:^BOOL(SXQSupplier *finalSupplier) {
                return finalSupplier != nil;
        }]
            subscribeNext:^(SXQSupplier *finalSupplier) {
                [_supplierBtn setTitle:finalSupplier.supplierName forState:UIControlStateNormal];
        }];
    }else if([item isKindOfClass:[SXQExpConsumable class]])
    {
        
        SXQExpConsumable *consumble = (SXQExpConsumable *)item;
        
        [RACObserve(consumble, consumableName) subscribeNext:^(NSString *consumableName) {
            _itemLabel.text = consumableName;
        }];
        if (consumble.preferSupplier) {
            [_supplierBtn setTitle:consumble.preferSupplier.supplierName forState:UIControlStateNormal];
        }else
        {
            [_supplierBtn setTitle:kDefaultBtnTitle forState:UIControlStateNormal];
        }
        [[RACObserve(consumble, finalSupplier)
          filter:^BOOL(SXQSupplier *finalSupplier) {
            return finalSupplier != nil;
        }]
         subscribeNext:^(SXQSupplier *finalSupplier) {
             [_supplierBtn setTitle:finalSupplier.supplierName forState:UIControlStateNormal];
        }];
    }else
    {
        SXQExpEquipment *equipment = (SXQExpEquipment *)item;
        [RACObserve(equipment, equipmentName) subscribeNext:^(NSString *equipmentName) {
            _itemLabel.text = equipmentName;
        }];
        
        if (equipment.preferSupplier) {
            [_supplierBtn setTitle:equipment.preferSupplier.supplierName forState:UIControlStateNormal];
        }else
        {
            [_supplierBtn setTitle:kDefaultBtnTitle forState:UIControlStateNormal];
        }
        [[RACObserve(equipment, finalSupplier)
          filter:^BOOL(SXQSupplier *finalSupplier) {
            return finalSupplier != nil;
        }]
         subscribeNext:^(SXQSupplier *finalSupplier) {
            [_supplierBtn setTitle:finalSupplier.supplierName forState:UIControlStateNormal];
        }];
    }
}
- (IBAction)supplierBtnClicked:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(supplierCell:clickedBtn:)]) {
        [_delegate supplierCell:self clickedBtn:sender];
    }
}
@end
