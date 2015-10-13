//
//  SXQExpeirmentController.m
//  实验助手
//
//  Created by sxq on 15/9/14.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
#import "SXQMyInstructionsController.h"
#import "UIBarButtonItem+SXQ.h"
#import "SXQDoneExperimentController.h"
#import "SXQExpeirmentController.h"
#import "SXQSegmentedControll.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SXQNowExperimentController.h"
#import "SXQDoneExperimentController.h"
@interface SXQExpeirmentController ()
@property (nonatomic,weak) UISegmentedControl *segmentedControl;
@property (nonatomic,assign) NSUInteger currentIndex;
@end

@implementation SXQExpeirmentController
- (instancetype)init
{
    if (self = [super init]) {
        _currentIndex = 0;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildViewControllers];
    [self setupSelf];
}
- (void)setupChildViewControllers
{
    SXQNowExperimentController *nowVC = [SXQNowExperimentController new];
    SXQDoneExperimentController *doneVC = [SXQDoneExperimentController new];
    [self addChildViewController:nowVC];
    [self addChildViewController:doneVC];
}
- (void)setupSelf
{
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"进行中",@"已完成"]];
    segmentedControl.selectedSegmentIndex = _currentIndex;
    segmentedControl.tintColor = [UIColor whiteColor];
    self.navigationItem.titleView = segmentedControl;
    _segmentedControl = segmentedControl;
    [_segmentedControl addTarget:self action:@selector(changeViewController:) forControlEvents:UIControlEventValueChanged];
    [_segmentedControl setSelectedSegmentIndex:0];
    [self changeViewController:_segmentedControl];
    //right barButton
    UIBarButtonItem *rightBarButton = [UIBarButtonItem itemWithImage:@"Night_ZHNavigationBarAddIcon_iOS7" target:self action:@selector(addInstruction)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
   
}
- (void)changeViewController:(UISegmentedControl *)segmentedControl
{
    self.view.window.backgroundColor = [UIColor whiteColor];
    NSUInteger newIndex = segmentedControl.selectedSegmentIndex;
    //1.新控制器
    UIViewController *newVC = self.childViewControllers[newIndex];
    if (newVC.view.superview) return;
    newVC.view.frame = self.view.bounds;
    
    //2.旧控制器
    UIViewController *oldVC = self.childViewControllers[_currentIndex];
    if (oldVC.view.superview) {
        [oldVC.view removeFromSuperview];
        [self.view addSubview:newVC.view];
        //transition
        CATransition *transition = [CATransition animation];
        transition.type = kCATransitionPush;
        if (_currentIndex < newIndex) {
            transition.subtype = kCATransitionFromLeft;
        }else
        {
            transition.subtype = kCATransitionFromRight;
        }
        
        transition.duration = 0.5;
        [self.view.layer addAnimation:transition forKey:nil];
    }else
    {
        [self.view addSubview:newVC.view];
    }
    _currentIndex = newIndex;
    
}
#pragma mark - Private Method
- (void)addInstruction
{
    [self.navigationController pushViewController:[SXQMyInstructionsController new] animated:YES];
}
@end
