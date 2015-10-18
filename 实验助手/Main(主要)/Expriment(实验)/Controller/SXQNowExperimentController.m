//
//  SXQNowExperimentController.m
//  实验助手
//
//  Created by sxq on 15/9/14.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
#define Identifier @"cell"
#import "SXQDBManager.h"
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
@property (nonatomic,strong) NSMutableArray *cacheVC;
@end

@implementation SXQNowExperimentController
- (NSMutableArray *)cacheVC
{
    if (_cacheVC == nil) {
        _cacheVC = [NSMutableArray array];
    }
    return _cacheVC;
}
- (NSArray *)experiments
{
    if (!_experiments) {
        _experiments = @[];
    }
    return _experiments;
}
- (void)viewWillAppear:(BOOL)animated
{
   self.experiments = [[SXQDBManager sharedManager] fetchOnDoingExperiment];
    _nowDataSource.items = self.experiments;
    [self.tableView reloadData];
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSelf];
    
}
- (void)setupSelf
{
    self.title = @"进行中";
    [self setupTableView];
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
    
    SXQExperimentModel *experiment = self.experiments[indexPath.row];
    UIViewController *cacheVc = [self cachedVcWithExperimentModel:experiment];
    if (cacheVc) {
        [self.navigationController pushViewController:cacheVc animated:YES];
        return;
    }
    SXQCurrentExperimentController *stepVC = [[SXQCurrentExperimentController alloc] initWithExperimentModel:experiment];
    [self.navigationController pushViewController:stepVC animated:YES];
    [self.cacheVC addObject:stepVC];
}
- (UIViewController *)cachedVcWithExperimentModel:(SXQExperimentModel *)experiment
{
    __block UIViewController *vc = nil;
    [self.cacheVC enumerateObjectsUsingBlock:^(SXQCurrentExperimentController *currentVc, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([currentVc.experimentModel.myExpID isEqualToString:experiment.myExpID]) {
            vc = currentVc;
            *stop = YES;
        }
    }];
    return vc;
}
@end
