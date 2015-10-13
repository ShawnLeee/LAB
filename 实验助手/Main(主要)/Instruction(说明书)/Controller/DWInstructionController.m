//
//  DWInstructionController.m
//  实验助手
//
//  Created by sxq on 15/9/16.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
#import "SXQInstructionListController.h"
#import "DWInstructionController.h"
#import "DWInstructionChildController.h"
#import "SXQMenuViewController.h"
#import "SXQColor.h"
#import "UIView+MJ.h"
#import "SXQExpSubCategory.h"
@interface DWInstructionController ()<DWInstructionChildControllerDelegate>
@property (nonatomic,assign) BOOL menuFold;
@property (nonatomic,weak) UICollectionView *centerView;

@end

@implementation DWInstructionController

- (instancetype)init
{
    if (self = [super init]) {
        _menuFold = NO;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setup];
}
- (void)p_setup
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [button addTarget:self action:@selector(menuButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    //初始化子控制器
    //1.左侧菜单
    SXQMenuViewController *menuVC = [SXQMenuViewController new];
    menuVC.view.width = MJMenuWidth;
    menuVC.view.y = 0;
    menuVC.view.height = self.view.frame.size.height;
    [self.view addSubview:menuVC.view];
    [self addChildViewController:menuVC];
    
    //2.中间内容
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(80, 80);
    DWInstructionChildController *centerVC = [[DWInstructionChildController alloc] initWithCollectionViewLayout:layout];
    centerVC.collectionView.frame = CGRectOffset(self.view.bounds, MJMenuWidth, 0);
    centerVC.delegate = self;
    [self.view addSubview:centerVC.collectionView];
    _centerView = centerVC.collectionView;
    [self addChildViewController:centerVC];
    
    menuVC.delegate = centerVC;
    // 2.监听手势
    [_centerView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragView:)]];
}
- (void)dragView:(UIPanGestureRecognizer *)panGesture
{
    CGPoint point = [panGesture translationInView:panGesture.view];
    //Drag ended.
    if (panGesture.state == UIGestureRecognizerStateCancelled || panGesture.state == UIGestureRecognizerStateEnded) {
        if (panGesture.view.x <= MJMenuWidth * 0.5) {//往左边走动至少一半
            [self p_foldMenu];
        }else
        {
            [self p_unfoldMenu];
        }
    }else//while draging
    {
        panGesture.view.transform = CGAffineTransformTranslate(panGesture.view.transform, point.x, 0);
        [panGesture setTranslation:CGPointZero inView:panGesture.view];
        if (panGesture.view.x <= 0) {
            panGesture.view.transform = CGAffineTransformMakeTranslation(-MJMenuWidth, 0);
        }else if(panGesture.view.x >= MJMenuWidth)
        {
            panGesture.view.transform = CGAffineTransformIdentity;
        }
    }
}
- (void)menuButtonClicked
{
    if (_menuFold) {
        [self p_unfoldMenu];
    }else
    {
        [self p_foldMenu];
    }
}
#pragma mark - Private Method
- (void)p_foldMenu
{
    [UIView animateWithDuration:0.5 animations:^{
         _centerView.transform = CGAffineTransformMakeTranslation(-MJMenuWidth, 0);
    }];
    _menuFold = !_menuFold;
}
- (void)p_unfoldMenu
{
    [UIView animateWithDuration:0.5 animations:^{
        _centerView.transform = CGAffineTransformIdentity;
    }];
    _menuFold = !_menuFold;
}

#pragma mark instuctionController Delegate Method
- (void)instructionController:(DWInstructionChildController *)vc SelectedItem:(SXQExpSubCategory *)item
{
    SXQInstructionListController *listVC = [SXQInstructionListController new];
    listVC.categoryItem = item;
    [self.navigationController pushViewController:listVC  animated:YES];
}
@end
