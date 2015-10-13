//
//  DWInstrucitonHeader.h
//  实验助手
//
//  Created by sxq on 15/9/23.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class SXQExpInstruction;
#import <UIKit/UIKit.h>

@interface DWInstrucitonHeader : UIView
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
- (void)configureHeaderWithInstruction:(SXQExpInstruction *)instruction;
@end
