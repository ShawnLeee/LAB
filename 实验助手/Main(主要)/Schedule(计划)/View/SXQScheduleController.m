//
//  SXQScheduleController.m
//  实验助手
//
//  Created by sxq on 15/10/21.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "SXQScheduleController.h"
#import "FSCalendarTestMacros.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SXQScheduleServicesImpl.h"
#import "ArrayDataSource+TableView.h"
#import "SXQExperimentModel.h"
@interface SXQScheduleController ()
@property (nonatomic,strong) id<SXQScheduleServices> services;
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,strong) ArrayDataSource *tableDataSource;
@end

@implementation SXQScheduleController
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        _services = [SXQScheduleServicesImpl new];
    }
    return self;
}
- (instancetype)init
{
    if (self = [super init]) {
        _services = [SXQScheduleServicesImpl new];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [_calendar selectDate:[[NSDate date] fs_dateByAddingDays:1]];
    [self binding];
#if 0
    FSCalendarTestSelectDate
#endif
}
- (void)binding
{
    @weakify(self)
    [[[[[self rac_signalForSelector:@selector(calendar:didSelectDate:) fromProtocol:@protocol(FSCalendarDelegate)]
     map:^id(RACTuple *tuple) {
         return tuple.second;
     }]
      map:^id(NSDate *date) {
          return [self dateStringForDate:date];
      }]
     flattenMap:^RACStream *(NSString *date) {
         @strongify(self)
         return [[self.services getServices] scheduleWithDate:date];
     }]
    subscribeNext:^(NSArray *expmentModelArr) {
        @strongify(self)
        self.tableDataSource.items = expmentModelArr;
        [self.tableView reloadData];
    }]; 
}
- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
    self.view = view;
    
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 0, view.bounds.size.width, 300)];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.allowsMultipleSelection = NO;
    [self.view addSubview:calendar];
    self.calendar = calendar;
    
    CGFloat calendarMaxY = CGRectGetMaxY(calendar.frame);
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, calendarMaxY, view.bounds.size.width, view.bounds.size.height - calendarMaxY) style:UITableViewStylePlain];
    _tableView = tableView;
    [self.view addSubview:tableView];
    [self setupTableViewDataSource];
    
}
- (void)setupTableViewDataSource
{
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableDataSource = [[ArrayDataSource alloc] initWithItems:@[] cellIdentifier:@"cell" cellConfigureBlock:^(UITableViewCell *cell, SXQExperimentModel *item) {
        cell.textLabel.text = item.experimentName;
    }];
    _tableView.dataSource = _tableDataSource;
}
- (NSString *)dateStringForDate:(NSDate *)date
{
    return [date fs_stringWithFormat:@"yyyy-MM-dd"];
}

@end
