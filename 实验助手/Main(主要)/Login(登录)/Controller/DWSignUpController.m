//
//  DWSignUpController.m
//  实验助手
//
//  Created by sxq on 15/10/20.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "DWSignUpController.h"

@interface DWSignUpController ()

@end

@implementation DWSignUpController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    [self setupTableViewFooter];
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}
- (void)setupTableViewFooter
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn = button;
    [button setBackgroundColor:[UIColor colorWithRed:0.29 green:0.47 blue:0.78 alpha:1.0]];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button setTitle:@"确认" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    button.frame = CGRectMake(0, 0, 10,44);
    self.tableView.tableFooterView = button;
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 35, 0);
}
@end
