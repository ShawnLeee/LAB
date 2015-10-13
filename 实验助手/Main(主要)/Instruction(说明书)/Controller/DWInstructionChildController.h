//
//  DWInstructionChildController.h
//  实验助手
//
//  Created by sxq on 15/9/16.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
@class DWInstructionChildController;
#import <UIKit/UIKit.h>
#import "SXQMenuViewController.h"
@protocol DWInstructionChildControllerDelegate <NSObject>
@optional
- (void)instructionController:(DWInstructionChildController *)vc SelectedItem:(id)item;
@end
@interface DWInstructionChildController : UICollectionViewController<SXQMenuViewControllerDelegate>
@property (nonatomic,weak) id<DWInstructionChildControllerDelegate> delegate;
@end
