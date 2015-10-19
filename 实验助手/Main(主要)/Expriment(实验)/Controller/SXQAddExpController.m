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
#import "SXQExpReagent.h"
#import "SXQReagentCountView.h"
#define countWidth ([UIScreen mainScreen].bounds.size.width - 20)
#define countHeight 40
@interface SXQAddExpController ()
@property (nonatomic,strong) SXQInstructionData *instructionData;
@property (nonatomic,weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic,weak) IBOutlet NSLayoutConstraint *widthConstans;
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
    [self setupNav];
    [self setUpCountView];
}
- (void)setupNav{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"确认" action:^{
       //写入数据到正在进行的实验
        [SXQMyExperimentManager addExperimentWithInstructionData:_instructionData completion:^(BOOL success,SXQExperimentModel *experiment) {
            if(success)//转到正在该实验正在进行的界面
            {
                UIViewController *rootVC = [self.navigationController.viewControllers firstObject];
                SXQCurrentExperimentController *currentVC = [[SXQCurrentExperimentController alloc] initWithExperimentModel:experiment];
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
- (void)setUpCountView
{
    CGFloat countX = 10;
    __block CGFloat countY = 0;
    [_instructionData.expReagent enumerateObjectsUsingBlock:^(SXQExpReagent *reagent, NSUInteger idx, BOOL * _Nonnull stop) {
        SXQReagentCountView *countView = [[SXQReagentCountView alloc] init];
        countView.reagent = reagent;
        countY = idx * (8 + countHeight);
        countView.frame = CGRectMake(countX, countY, countWidth, countHeight);
        [self.scrollView addSubview:countView];
        self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(countView.frame) + 20) ;
    }];
}
- (void)viewDidLayoutSubviews
{
    self.widthConstans.constant = ([UIScreen mainScreen].bounds.size.width - 20)/5.0;
    [self.view layoutIfNeeded];
}

@end
