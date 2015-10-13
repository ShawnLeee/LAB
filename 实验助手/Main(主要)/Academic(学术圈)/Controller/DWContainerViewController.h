//
//  DWContainerViewController.h
//  DWContainerViewController
//
//  Created by sxq on 15/9/17.
//  Copyright (c) 2015年 sxq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DWContainerViewController : UIViewController

@property (nonatomic,copy,readonly) NSArray *viewControllers;

@property (nonatomic,assign) UIViewController *selectedViewController;
- (instancetype)initWithViewControllers:(NSArray *)viewControllers;
@end
