//
//  SXQSupplierListController.m
//  实验助手
//
//  Created by sxq on 15/9/30.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "SXQSupplierListController.h"
#import "ArrayDataSource+TableView.h"
#import "SXQSupplierListData.h"
#import "SXQSupplier.h"
#import "SXQExpReagent.h"
@interface SXQSupplierListController ()
@property (nonatomic,copy) SupplierChoosedBlk supplierBlk;
@property (nonatomic,strong) ArrayDataSource *supplierDataSource;
@property (nonatomic,strong) NSArray *suppliers;
@end

@implementation SXQSupplierListController
- (instancetype)initWithSuppliers:(NSArray *)suppliers supplierChoosedBlk:(SupplierChoosedBlk)supplierBlk
{
    if (self = [super init]) {
        _suppliers = suppliers;
        _supplierBlk = [supplierBlk copy];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTheData];
    [self setupTableView];
}
- (void)setupTableView
{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.dataSource = _supplierDataSource;
}
-(void)setupTheData
{
    
    _supplierDataSource = [[ArrayDataSource alloc] initWithItems:_suppliers  cellIdentifier:@"cell" cellConfigureBlock:^(UITableViewCell *cell,SXQSupplier *supplier) {
        cell.textLabel.text = supplier.supplierName;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }];
    self.tableView.dataSource = _supplierDataSource;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _supplierBlk(_suppliers[indexPath.row]);
}

@end
