//
//  SXQExperimentDetailController.m
//  实验助手
//
//  Created by sxq on 15/9/14.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
#define StepIdentifier @"SXQExperimentStepCell"
#define EquipmentIdentifier @"SXQEquipMentCell"
#import "ArrayDataSource+TableView.h"
#import "SXQExperimentDetailController.h"
#import "DWGroup.h"
#import "SXQEquipMentCell.h"
#import "SXQExperimentStepCell.h"
#import "SXQExperimentStepController.h"
#import "SXQEquimentController.h"
@interface SXQExperimentDetailController ()
@property (nonatomic,strong) ArrayDataSource *groupDataSource;
@property (nonatomic,strong) NSArray *groups;
@end

@implementation SXQExperimentDetailController
- (NSArray *)groups
{
    if (_groups == nil) {
        DWGroup *group0 = [DWGroup groupWithItems:@[@"step1",@"step2",@"step3",@"step4"]];
        group0.headerTitle = @"实验步骤";
        group0.identifier = StepIdentifier;
        group0.configureBlk = ^(SXQExperimentStepCell *cell,NSString *title){
            cell.textLabel.text = title;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        };
        DWGroup *group1 = [DWGroup groupWithItems:@[@"试剂",@"仪器",@"耗材"]];
        group1.identifier = EquipmentIdentifier;
        group1.configureBlk = group0.configureBlk;
        group1.headerTitle = @"实验必备";
        _groups = @[group0,group1];
    }
    return _groups;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSelf];
}
- (void)setupSelf
{
    self.title = @"实验一";
    [self setupTableView];
}
- (void)setupTableView
{
    [self.tableView registerNib:[UINib nibWithNibName:@"SXQExperimentStepCell" bundle:nil] forCellReuseIdentifier:StepIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"SXQEquipMentCell" bundle:nil] forCellReuseIdentifier:EquipmentIdentifier];
    _groupDataSource = [[ArrayDataSource alloc] initWithGroups:self.groups];
    self.tableView.dataSource = _groupDataSource;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if([cell isKindOfClass:[SXQExperimentStepCell class]])
    {
        SXQExperimentStepController *stepVC = [SXQExperimentStepController new];
        stepVC.title = cell.textLabel.text;
        [self.navigationController pushViewController:stepVC animated:YES];
    }else
    {
        SXQEquimentController *equimentVC = [SXQEquimentController new];
        equimentVC.title = cell.textLabel.text;
        [self.navigationController pushViewController:equimentVC animated:YES];
    }
}
@end
