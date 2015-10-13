//
//  ArrayDataSource+TableView.m
//  SXQMovie
//
//  Created by SXQ on 15/8/11.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
#import "DWGroup.h"
#import "ArrayDataSource+TableView.h"

@implementation ArrayDataSource (TableView)
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.isGroupArray) {
        return self.items.count;
    }
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!self.isGroupArray) {
        return self.items.count;
    }else
    {
        DWGroup *group = self.items[section];
        return group.items.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    id item = [self itemAtIndexPath:indexPath];
    
    if (self.isGroupArray) {
        DWGroup *group = self.items[indexPath.section];
        cell = [tableView dequeueReusableCellWithIdentifier:group.identifier forIndexPath:indexPath];
        if(group.configureBlk)
        {
            group.configureBlk(cell,item);
        }
    }else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
        self.configureBlock(cell,item);
    }
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.isGroupArray) {
        DWGroup *group = self.items[section];
        return group.headerTitle;
    }
    return nil;
}
@end
