//
//  SXQDoneExperimentController.m
//  实验助手
//
//  Created by sxq on 15/9/14.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
#import "ArrayDataSource+TableView.h"
#import "SXQDoneExperimentController.h"
#import "SXQExperimentModel.h"
#import "ExperimentTool.h"
@interface SXQDoneExperimentController ()
@property (nonatomic,strong) ArrayDataSource *dataSource;
@property (nonatomic,strong) NSArray *experiments;
@end

@implementation SXQDoneExperimentController
- (instancetype)init
{
    if(self = [super init])
    {
        _experiments = @[];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self p_setupTable];
    [self p_loadData];
    
}
- (void)p_loadData
{
    [ExperimentTool fetchDoneExperimentWithParam:nil completion:^(NSArray *resultArray) {
        _dataSource.items = resultArray;
        _experiments = resultArray;
        [self.tableView reloadData];
    }];
}
- (void)p_setupTable
{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _dataSource = [[ArrayDataSource alloc] initWithItems:_experiments cellIdentifier:@"cell" cellConfigureBlock:^(UITableViewCell *cell, SXQExperimentModel *experimentModel) {
        cell.textLabel.text = experimentModel.experimentName;
    }];
    self.tableView.dataSource = _dataSource;
}

#pragma mark - TableView Delegate Method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SXQExperimentModel *experimentModel = _experiments[indexPath.row];
}
@end
