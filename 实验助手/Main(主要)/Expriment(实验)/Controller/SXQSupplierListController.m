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
@property (nonatomic,strong) SXQSupplierListData *supplierData;
@property (nonatomic,copy) NSString *reagentID;
@end

@implementation SXQSupplierListController
- (instancetype)initWithReagent:(SXQExpReagent *)reagent supplierChoosedBlk:(SupplierChoosedBlk)supplierBlk
{
    if (self = [super init]) {
        _reagentID = reagent.reagentID;
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
    
    _supplierDataSource = [[ArrayDataSource alloc] initWithItems:@[]  cellIdentifier:@"cell" cellConfigureBlock:^(UITableViewCell *cell,SXQSupplier *supplier) {
        cell.textLabel.text = supplier.supplierName;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }];
    
    _supplierData = [[SXQSupplierListData alloc] initWithReagentID:_reagentID dataLoadedComplete:^(BOOL success) {
        _supplierDataSource.items = _supplierData.suppliers;
        [self.tableView reloadData];
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SXQSupplier *supplier = _supplierData.suppliers[indexPath.row];
    _supplierBlk(supplier);
}

@end
