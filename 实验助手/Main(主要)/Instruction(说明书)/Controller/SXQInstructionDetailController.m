//
//  SXQInstructionDetailController.m
//  实验助手
//
//  Created by sxq on 15/9/23.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWActionSheet.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SXQInstructionDetail.h"
#import "InstructionTool.h"
#import "ArrayDataSource+TableView.h"
#import "DWGroup.h"
#import "SXQInstructionDetailController.h"
#import "SXQExpInstruction.h"
#import "SXQInstructionStep.h"
#import "SXQInstructionStepCell.h"
#import "SXQSingleContentCell.h"
#import "DWInstrucitonHeader.h"
#import "DWInstructionActionView.h"
#define StepCellIdentifier @"Instruction Step Cell"
#define SingleContentIdentifier @"Single Content Cell"
@interface SXQInstructionDetailController ()
@property (nonatomic,strong) SXQExpInstruction *instruction;
@property (nonatomic,strong) ArrayDataSource *instructionDataSource;
@property (nonatomic,strong) NSArray *groups;
@end

@implementation SXQInstructionDetailController

- (instancetype)initWithInstruction:(SXQExpInstruction *)instruction
{
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        _instruction = instruction;
        _groups = @[];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupTableView];
    [self p_loadData];
}

- (void)p_setupTableView
{
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SXQInstructionStepCell" bundle:nil] forCellReuseIdentifier:StepCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"SXQSingleContentCell" bundle:nil] forCellReuseIdentifier:SingleContentIdentifier];
    _instructionDataSource = [[ArrayDataSource alloc] initWithGroups:_groups];
    self.tableView.dataSource = _instructionDataSource;
    [self p_setupTableHeader];
}
- (void)p_setupTableHeader
{
    DWInstrucitonHeader *instructionHeader = [[DWInstrucitonHeader alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 80)];
    [instructionHeader configureHeaderWithInstruction:_instruction];
    self.tableView.tableHeaderView = instructionHeader;
    [[instructionHeader.editBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        DWActionSheet *actionSheet = [[DWActionSheet alloc] initWithHandler:^(DWActionButtonType buttonType) {
#warning hanler the events;
        }];
    
        [actionSheet show];
    }];
}
- (void)p_loadData
{
    InstructionDetailParam *param = [InstructionDetailParam new];
    param.userID = @"4028c681494b994701494b99aba50000";
    param.expInstructionID = _instruction.expInstructionID;
    [InstructionTool fetchInstructionDetailWithParam:param success:^(InstructionDetailResult *result) {
        _groups = [self groupsWithResult:result];
        _instructionDataSource.items = _groups;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
- (NSArray *)groupsWithResult:(InstructionDetailResult *)result
{
    DWGroup *group0 = [DWGroup groupWithItems:@[result.data.experimentDesc] identifier:SingleContentIdentifier  header:@"技术简介"];
    group0.configureBlk = ^(SXQSingleContentCell *cell,NSString *item){
        [cell configureCellWithItem:item];
    };
    DWGroup *group1 = [DWGroup groupWithItems:@[result.data.experimentTheory] identifier:SingleContentIdentifier header:@"技术原理"];
    group1.configureBlk = group0.configureBlk;
    
    DWGroup *group2 = [DWGroup groupWithItems:@[@"准备"] identifier:SingleContentIdentifier header:@"实验准备"];
    group2.configureBlk = group0.configureBlk;
    
    DWGroup *group3 = [DWGroup groupWithItems:result.data.steps identifier:StepCellIdentifier header:@"实验流程"];
    group3.configureBlk = ^(SXQInstructionStepCell *cell,SXQInstructionStep *instrucitonStep){
        [cell configureCellWithItem:instrucitonStep];
    };
    
    NSArray *groups = @[group0,group1,group2,group3];
    
    return groups;
}
@end
