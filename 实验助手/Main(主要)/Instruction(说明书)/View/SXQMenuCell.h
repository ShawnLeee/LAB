//
//  SXQMenuCell.h
//  实验助手
//
//  Created by sxq on 15/9/16.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SXQMenuCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *itemTitle;
- (void)configureCellWithItem:(id)item;
@end
