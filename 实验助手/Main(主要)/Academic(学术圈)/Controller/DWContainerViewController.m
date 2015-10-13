//
//  DWContainerViewController.m
//  DWContainerViewController
//
//  Created by sxq on 15/9/17.
//  Copyright (c) 2015年 sxq. All rights reserved.
//

#import "DWContainerViewController.h"
#import "DWBBSViewController.h"
#import "DWExchangeController.h"
#import "DWConsultTViewController.h"
@interface DWContainerViewController ()<UIScrollViewDelegate>

@property (nonatomic,copy) NSArray *viewControllers;
@property (nonatomic,strong) UIView *containerView;
@property (nonatomic,assign) NSUInteger selectedIndex;
@property (nonatomic,strong) UISegmentedControl *segmentControl;
@end

@implementation DWContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"学术交流及最新资讯";
//    self.view.backgroundColor = [UIColor grayColor];
    [self loadViewCustomView];
    [self transitionFrom:0 to:0];
}
- (instancetype)initWithViewControllers:(NSArray *)viewControllers
{
    NSParameterAssert([viewControllers count] > 0);
    if (self = [super init]) {
        self.viewControllers = [viewControllers copy];
    }
    return self;
}
- (void)loadViewCustomView
{
    NSArray *vcs = @[[DWBBSViewController new],[DWConsultTViewController new],[DWExchangeController new]];
    _viewControllers = vcs;
   
    //Add containerView and segmentControl
    _segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"BBS交流",@"前沿资讯",@"试剂交换"]];
    _segmentControl.tintColor = [UIColor grayColor];
    _selectedIndex = 0;
    _segmentControl.selectedSegmentIndex = _selectedIndex;
    [_segmentControl addTarget:self action:@selector(pressedSeg:) forControlEvents:UIControlEventValueChanged];
    
    
    _containerView = [[UIView alloc] init];
    _containerView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_segmentControl];
    [self.view addSubview:_containerView];
    
    _segmentControl.translatesAutoresizingMaskIntoConstraints = NO;
    _containerView.translatesAutoresizingMaskIntoConstraints = NO;
    
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_segmentControl attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_segmentControl attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_segmentControl attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_segmentControl attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_containerView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_containerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_segmentControl attribute:NSLayoutAttributeBottom multiplier:1 constant:1]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_containerView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_containerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
}
- (void)pressedSeg:(UISegmentedControl *)seg
{
    [self transitionFrom:_selectedIndex to:seg.selectedSegmentIndex];
    _selectedIndex = seg.selectedSegmentIndex;
}
- (void)transitionFrom:(NSUInteger)from to:(NSUInteger)to
{
    // 1.新控制器
    UIViewController *newVc = self.viewControllers[to];
    if (newVc.view.superview) return;
    newVc.view.frame = _containerView.bounds;
    
    // 取出导航控制器的根控制器设置背景色
//    UIViewController *rootVc = [newVc.childViewControllers firstObject];
    
    // 2.旧控制器
    UIViewController *oldVc;
    // 取出最后一个子控制器
    UIViewController *lastVc = [self.viewControllers lastObject];
    if (lastVc.view.superview) { // 如果最后一个控制器正在显示
        oldVc = lastVc;
    } else {
        oldVc = self.viewControllers[from];
    }
    
    // 3.转场动画
    if (oldVc.view.superview) { // 正在显示这个旧控制器
        [oldVc.view removeFromSuperview];
        [_containerView addSubview:newVc.view];
        
        // 转场动画
        CATransition *transition = [CATransition animation];
        transition.type = kCATransitionPush;
        if (from > to) {
            transition.subtype = kCATransitionFromRight;
        }else
        {
            transition.subtype = kCATransitionFromLeft;
        }
        transition.duration = 0.5;
        [_containerView.layer addAnimation:transition forKey:nil];
    } else { // 没有显示任何控制器
        [_containerView addSubview:newVc.view];
    }
}
@end
