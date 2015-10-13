//
//  SXQMenuViewController.h
//  实验助手
//
//  Created by sxq on 15/9/16.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
@class SXQMenuViewController,SXQExpCategory;
#import <UIKit/UIKit.h>
@protocol SXQMenuViewControllerDelegate <NSObject>
@optional
- (void)menuViewController:(SXQMenuViewController *)vc selectedItem:(SXQExpCategory *)item;
@end

@interface SXQMenuViewController : UITableViewController
@property (nonatomic,weak) id<SXQMenuViewControllerDelegate> delegate;
@end
