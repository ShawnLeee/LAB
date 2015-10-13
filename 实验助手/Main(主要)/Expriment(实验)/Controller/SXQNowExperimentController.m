//
//  SXQNowExperimentController.m
//  实验助手
//
//  Created by sxq on 15/9/14.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
#define Identifier @"cell"
#import "ArrayDataSource+TableView.h"
#import "SXQCurrentExperimentController.h"
#import "SXQNowExperimentController.h"
#import "SXQExperimentModel.h"
#import "ExperimentTool.h"
#import "SXQCurrentExperimentController.h"
#import "SXQExperimentResult.h"
@interface SXQNowExperimentController ()
@property (nonatomic,strong) ArrayDataSource *nowDataSource;
@property (nonatomic,strong) NSArray *experiments;
@end

@implementation SXQNowExperimentController
- (NSArray *)experiments
{
    if (!_experiments) {
        _experiments = @[];
    }
    return _experiments;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSelf];
    
}
- (void)setupSelf
{
    self.title = @"进行中";
    [self setupTableView];
    [self p_loadData];
}
- (void)p_loadData
{
    [ExperimentTool fetchDoingExperimentWithParam:nil success:^(SXQExperimentResult *result) {
        _nowDataSource.items = result.data;
        _experiments = result.data;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
- (void)setupTableView
{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:Identifier];
    _nowDataSource = [[ArrayDataSource alloc] initWithItems:self.experiments cellIdentifier:Identifier cellConfigureBlock:^(UITableViewCell *cell, SXQExperimentModel *model) {
        cell.textLabel.text = model.experimentName;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }];
    self.tableView.dataSource = _nowDataSource;
}
#pragma mark - TableView Delegate Method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SXQCurrentExperimentController *stepVC = [[SXQCurrentExperimentController alloc] initWithMyExpId:nil];
//    stepVC.experimentModel = self.experiments[indexPath.row];
    [self.navigationController pushViewController:stepVC animated:YES];
}

@end
