//
//  SXQReagentListController.m
//  实验助手
//
//  Created by sxq on 15/9/30.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQExpEquipment.h"
#import "SXQExpConsumable.h"
#import "DWGroup.h"
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
#import "SXQSupplierCell.h"

#import "SXQSupplierProtocol.h"

#define ReagentCellIdentifier @"Reagent Cell"
#define SupplierCellIdentifier @"Supplier Cell"
@interface SXQReagentListController ()<SXQSupplierDelegate>
@property (nonatomic,strong) id instruction;
@property (nonatomic,strong) ArrayDataSource *reagentDataSource;
@property (nonatomic,strong) SXQReagentListData *reagentData;
@property (nonatomic,weak) FPPopoverController *popOver;
@property (nonatomic,strong) SXQInstructionData *instructionData;
@property (nonatomic,strong) ArrayDataSource *supplierDataSource;
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
    [self.tableView registerNib:[UINib nibWithNibName:@"SXQSupplierCell" bundle:nil] forCellReuseIdentifier:SupplierCellIdentifier];
    [self setupTableDataSource];
}
- (void)setupTableDataSource
{
    DWGroup *group1 = [DWGroup groupWithItems:_instructionData.expReagent identifier:SupplierCellIdentifier header:@"试剂厂商" configureBlk:^(SXQSupplierCell *cell,SXQExpReagent  *item) {
        cell.delegate = self;
        [cell configureCellWithItem:item];
    }];
    DWGroup *group2 = [DWGroup groupWithItems:_instructionData.expConsumable identifier:SupplierCellIdentifier header:@"耗材厂商" configureBlk:^(SXQSupplierCell *cell, SXQExpConsumable *item) {
        cell.delegate = self;
        [cell configureCellWithItem:item];
    }];
    DWGroup *group3 = [DWGroup groupWithItems:_instructionData.expEquipment identifier:SupplierCellIdentifier header:@"设备厂商" configureBlk:^(SXQSupplierCell *cell, SXQExpEquipment *item) {
        cell.delegate = self;
        [cell configureCellWithItem:item];
    }];
    _supplierDataSource = [[ArrayDataSource alloc] initWithGroups:@[group1,group2,group3]];
    self.tableView.dataSource = _supplierDataSource;
}
- (SXQExpReagent *)reagentForCell:(SXQReagentCell *)cell
{
    NSIndexPath *indexpath = [self.tableView indexPathForCell:cell];
    return _reagentData.reagents[indexpath.row];
}

- (void)showPopoverWithItem:(id<SXQSupplierProcotol>)item sender:(UIButton *)sender
{
    SXQSupplierListController *supplierVC = [[SXQSupplierListController alloc] initWithSuppliers:[item totalSuppliers] supplierChoosedBlk:^(SXQSupplier *supplier) {
        [item updateSupplier:supplier.supplierName];
        [_popOver dismissPopoverAnimated:YES];
    }];
    FPPopoverController *popover = [[FPPopoverController alloc] initWithViewController:supplierVC];
    _popOver = popover;
    popover.tint = FPPopoverDefaultTint;
    popover.arrowDirection = FPPopoverArrowDirectionAny;
    [popover presentPopoverFromView:sender];
}
#pragma mark cell delegate method
- (void)supplierCell:(SXQSupplierCell *)cell clickedBtn:(UIButton *)button
{
    [self showPopoverWithItem:[self itemForCell:cell] sender:button];
}
- (id<SXQSupplierProcotol>)itemForCell:(SXQSupplierCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    DWGroup *group = _supplierDataSource.items[indexPath.section];
    return group.items[indexPath.row];
    
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
