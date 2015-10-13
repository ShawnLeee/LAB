//
//  SXQMenuViewController.m
//  实验助手
//
//  Created by sxq on 15/9/16.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//

#import "SXQMenuViewController.h"
#import "ArrayDataSource+TableView.h"
#import "SXQMenuCell.h"
#import "SXQColor.h"
#import "InstructionTool.h"
#import "SXQExpCategory.h"
#define Identifier @"SXQMenuCell"
@interface SXQMenuViewController ()
@property (nonatomic,strong) ArrayDataSource *menuDataSource;
@property (nonatomic,strong) NSArray *expcategories;
@end

@implementation SXQMenuViewController
- (instancetype)init{
    if (self = [super init] ) {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.backgroundColor = MenuCellBgColor;
        _expcategories = @[];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupTableView];
    [self p_loadData];
}
- (void)p_loadData
{
    [InstructionTool fetchAllExpSuccess:^(ExpCategoryResult *result) {
        _expcategories = result.data;
        _menuDataSource.items = result.data;
        [self.tableView reloadData];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
    } failure:^(NSError *error) {
        
    }];
}
- (void)p_setupTableView
{
    [self.tableView registerNib:[UINib nibWithNibName:@"SXQMenuCell" bundle:nil] forCellReuseIdentifier:Identifier];
    _menuDataSource = [[ArrayDataSource alloc] initWithItems:_expcategories cellIdentifier:Identifier  cellConfigureBlock:^(SXQMenuCell *cell, SXQExpCategory *item) {
        [cell configureCellWithItem:item];
    }];
    self.tableView.dataSource = _menuDataSource;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SXQExpCategory *item = _expcategories[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(menuViewController:selectedItem:)]) {
        [self.delegate menuViewController:self selectedItem:item];
    }
}
@end
