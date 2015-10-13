//
//  SXQReagentListController.m
//  实验助手
//
//  Created by sxq on 15/9/30.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQAddExpController.h"
#import "UIBarButtonItem+SXQ.h"
#import "FPPopoverController.h"
#import "SXQSupplierListController.h"
#import "SXQReagentListData.h"
#import "ArrayDataSource+TableView.h"
#import "SXQReagentListController.h"
#import "SXQExpReagent.h"
#import "SXQReagentCell.h"
#import "SXQSupplier.h"
#import "SXQHotInstruction.h"
#import "SXQMyGenericInstruction.h"
#import "SXQInstructionData.h"
#define ReagentCellIdentifier @"Reagent Cell"

@interface SXQReagentListController ()<SXQReagentCellDelegate>
@property (nonatomic,strong) id instruction;
@property (nonatomic,strong) ArrayDataSource *reagentDataSource;
@property (nonatomic,strong) SXQReagentListData *reagentData;
@property (nonatomic,weak) FPPopoverController *popOver;
@property (nonatomic,strong) SXQInstructionData *instructionData;
@end

@implementation SXQReagentListController
- (instancetype)initWithExpInstructionData:(SXQInstructionData *)instructionData
{
    if (self = [super init]) {
        _instructionData = instructionData;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupTableView];
    [self setupNav];
}
- (void)p_setupTableView
{
    [self.tableView registerNib:[UINib nibWithNibName:@"SXQReagentCell" bundle:nil] forCellReuseIdentifier:ReagentCellIdentifier];
    
    _reagentDataSource= [[ArrayDataSource alloc] initWithItems:_instructionData.expReagent cellIdentifier:ReagentCellIdentifier cellConfigureBlock:^(SXQReagentCell *cell, SXQExpReagent *reagent) {
        cell.delegate = self;
        [cell configureCellWithItem:reagent];
    }];
    self.tableView.dataSource = _reagentDataSource;
}
- (SXQExpReagent *)reagentForCell:(SXQReagentCell *)cell
{
    NSIndexPath *indexpath = [self.tableView indexPathForCell:cell];
    return _reagentData.reagents[indexpath.row];
}
- (void)showPopoverWithReagent:(SXQExpReagent *)reagent sender:(UIButton *)sender
{
    SXQSupplierListController *supplierVC = [[SXQSupplierListController alloc] initWithReagent:reagent supplierChoosedBlk:^(SXQSupplier *supplier) {
        [sender setTitle:supplier.supplierName forState:UIControlStateNormal];
        [_popOver dismissPopoverAnimated:YES];
    }];
    FPPopoverController *popover = [[FPPopoverController alloc] initWithViewController:supplierVC];
    _popOver = popover;
    popover.tint = FPPopoverDefaultTint;
    popover.arrowDirection = FPPopoverArrowDirectionAny;
    [popover presentPopoverFromView:sender];
}
#pragma mark reagentcell delegate method
- (void)reagentCell:(SXQReagentCell *)reagentCell clickedSupplierButton:(UIButton *)button
{
    [self showPopoverWithReagent:[self reagentForCell:reagentCell] sender:button];
}
#pragma mark setupNav
- (void)setupNav
{
    UIBarButtonItem *rightBarButton = [UIBarButtonItem itemWithTitle:@"下一步" action:^{
        SXQAddExpController *addExpController = [[SXQAddExpController alloc] initWithInstructionData:_instructionData];
        [self.navigationController pushViewController:addExpController animated:YES];
    }];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}
@end
