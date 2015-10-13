//
//  SXQEquimentController.m
//  实验助手
//
//  Created by sxq on 15/9/14.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
#import "ArrayDataSource+TableView.h"
#import "SXQEquimentController.h"

@interface SXQEquimentController ()
@property (nonatomic,strong) ArrayDataSource *equipDataSource;
@end

@implementation SXQEquimentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSelf];
}
- (void)setupSelf
{
    [self setupTableView];
}
- (void)setupTableView
{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _equipDataSource = [[ArrayDataSource alloc] initWithItems:@[self.title,self.title,self.title] cellIdentifier:@"cell" cellConfigureBlock:^(UITableViewCell *cell, NSString *title) {
        cell.textLabel.text = title;
    }];
    self.tableView.dataSource = _equipDataSource;
}




@end
