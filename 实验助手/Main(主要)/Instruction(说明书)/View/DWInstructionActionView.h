//
//  DWInstructionActionView.h
//  实验助手
//
//  Created by sxq on 15/9/23.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class DWActionButton;
#import <UIKit/UIKit.h>

@interface DWInstructionActionView : UIView
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet DWActionButton *editButton;
@property (weak, nonatomic) IBOutlet DWActionButton *uploadButton;
@property (weak, nonatomic) IBOutlet DWActionButton *cacheButton;
@property (weak, nonatomic) IBOutlet DWActionButton *retweatButton;

@end
