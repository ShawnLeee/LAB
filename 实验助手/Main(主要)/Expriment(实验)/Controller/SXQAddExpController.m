//
//  SXQAddExpController.m
//  实验助手
//
//  Created by sxq on 15/10/9.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQCurrentExperimentController.h"
#import "SXQAddExpController.h"
#import "UIBarButtonItem+SXQ.h"
#import "SXQMyExperimentManager.h"
#import "SXQInstructionData.h"
#import "MBProgressHUD+MJ.h"
@interface SXQAddExpController ()
@property (nonatomic,strong) SXQInstructionData *instructionData;
@end

@implementation SXQAddExpController
- (instancetype)initWithInstructionData:(SXQInstructionData *)instructionData
{
    if (self = [super init]) {
        _instructionData = instructionData;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupNav];
}
- (void)setupNav{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"确认" action:^{
       //写入数据到正在进行的实验
        [SXQMyExperimentManager addExperimentWithInstructionData:_instructionData completion:^(BOOL success,NSString *myExpId) {
            if(success)//转到正在该实验正在进行的界面
            {
                UIViewController *rootVC = [self.navigationController.viewControllers firstObject];
                SXQCurrentExperimentController *currentVC = [[SXQCurrentExperimentController alloc] initWithMyExpId:myExpId];
                currentVC.hidesBottomBarWhenPushed = YES;
                NSArray *viewControllers = @[rootVC,currentVC];
                [self.navigationController setViewControllers:viewControllers animated:YES];
            }else
            {
                [MBProgressHUD showError:@"添加失败!"];
            }
        }];
    }];
}



@end
