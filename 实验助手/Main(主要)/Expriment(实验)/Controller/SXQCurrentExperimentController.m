//
//  SXQCurrentExperimentController.m
//  实验助手
//
//  Created by sxq on 15/9/15.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
#import "RACEXTScope.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SXQExpStepFrame.h"
#import "SXQSaveReagentController.h"
#import "SXQMyExperimentManager.h"
#import "SXQNavgationController.h"
#import "SXQRemarkController.h"
#import "MBProgressHUD+MJ.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SXQCurrentExperimentController.h"
#import "SXQExperimentToolBar.h"
#import "ArrayDataSource+TableView.h"
#import "DWStepCell.h"
#import "ExperimentTool.h"
#import "SXQExperimentStepResult.h"
#import "SXQExperiment.h"
#import "SXQExpStep.h"
#import "SXQCurrentExperimentData.h"
#import "SXQExperimentModel.h"

@interface SXQCurrentExperimentController ()<UITableViewDelegate,SXQExperimentToolBarDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong) SXQCurrentExperimentData *currentExperimentData;
@property (weak, nonatomic) IBOutlet SXQExperimentToolBar *toolBar;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *experimentName;
@property (nonatomic,strong) SXQExperimentModel *experimentModel;
@property (nonatomic,strong) ArrayDataSource *stepsDataSource;
/**
 *  正在进行的实验步骤
 */
@property (nonatomic,strong) SXQExpStep *currentStep;
@end

@implementation SXQCurrentExperimentController
- (instancetype)initWithExperimentModel:(SXQExperimentModel *)experimentModel
{
    if (self = [super init]) {
        _experimentModel = experimentModel;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(test:) name:@"needreloadCell" object:nil];
    }
    return self;
}
- (void)test:(NSNotification *)notifation
{
    [self.tableView reloadData];
}
- (void)viewDidLayoutSubviews
{
    [_toolBar setNeedsUpdateConstraints];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupSelf];
    [self p_setupTableView];
    
}
- (void)p_setupTableView
{
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pattern-grey"]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"DWStepCell" bundle:nil] forCellReuseIdentifier:@"DWStepCell"];
    [self.tableView registerClass:[DWStepCell class] forCellReuseIdentifier:@"cell"];
    _stepsDataSource = [[ArrayDataSource alloc] initWithItems:@[] cellIdentifier:@"cell" cellConfigureBlock:^(DWStepCell *cell, SXQExpStepFrame *stepFrame) {
        cell.stepFrame = stepFrame;
    }];
    self.tableView.dataSource = _stepsDataSource;
    
     _currentExperimentData = [[SXQCurrentExperimentData alloc] initWithMyExpId:_experimentModel.myExpID completion:^(BOOL success) {
         NSMutableArray *tmp = [NSMutableArray array];
         [_currentExperimentData.expProcesses enumerateObjectsUsingBlock:^(SXQExpStep *step, NSUInteger idx, BOOL * _Nonnull stop) {
             SXQExpStepFrame *stepFrame = [[SXQExpStepFrame alloc] init];
             stepFrame.expStep = step;
             [tmp addObject:stepFrame];
         }];
         _stepsDataSource.items = tmp;
        [self.tableView reloadData];
    }];
    [self p_setupTableFooter];
}

- (void)p_setupTableFooter
{
    SXQExperimentToolBar *toolBar = [[SXQExperimentToolBar alloc] init];
//    toolBar.delegate = self;
    [self.view addSubview:toolBar];
    _toolBar = toolBar;
    toolBar.translatesAutoresizingMaskIntoConstraints = NO;
    [self layoutToolBar];
    [self binding];
    
}
- (void)layoutToolBar
{
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_toolBar attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomLayoutGuide attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_toolBar attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_toolBar attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_toolBar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:44]];
}
- (void)p_setupSelf
{
    _experimentName.text = _experimentModel.experimentName;
    self.navigationItem.title = @"实验步骤说明";
}
- (void)experimentToolBar:(SXQExperimentToolBar *)toolBar clickButtonWithType:(ExperimentTooBarButtonType)buttonType
{
    switch (buttonType) {
            case ExperimentTooBarButtonTypeBack:
            break;
            
            case ExperimentTooBarButtonTypePhoto:
            [self choosePhotoOrigin];
            break;
            
            case ExperimentTooBarButtonTypeStart:
            {//启动/暂停定时器
                if(!self.currentStep)
                {
                    [MBProgressHUD showError:@"请选择实验步骤"];
                }else
                {
                }
                
                break;
            }
            case ExperimentTooBarButtonTypeRemark:
            {
                [self addRemark:nil];
                break;
            }
            
            case ExperimentTooBarButtonTypeReport:
            break;
    }
}

- (void)addRemarkWithConfirm
{
    UIAlertController *remarkAlerVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *saveReagentAction = [UIAlertAction actionWithTitle:@"添加试剂保存位置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        SXQSaveReagentController *reagentVC = [[SXQSaveReagentController alloc] initWithExperimentStep:self.currentStep completion:^{
#warning Save current step reagent place
            SXQExperimentStep *step = self.currentStep;
        }];
        SXQNavgationController *nav =  [[SXQNavgationController alloc] initWithRootViewController:reagentVC];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [remarkAlerVC addAction:saveReagentAction];
//    [remarkAlerVC addAction:addRemarkAction];
    [remarkAlerVC addAction:cancelAction];
    [self.navigationController presentViewController:remarkAlerVC animated:YES completion:^{
        
    }];
}

#pragma mark - 图片选择控制器的代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 1.销毁picker控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 2.去的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self addExpImage:image];
}
- (void)choosePhotoOrigin
{
    if (!self.currentStep) {
        [MBProgressHUD showError:@"请选择实验步骤"];
        return;
    }
    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"从相册选一张" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           [self openPhotoLibrary];
    }];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍一张" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           [self openCamera];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertCon addAction:photoAction];
    [alertCon addAction:cameraAction];
    [alertCon addAction:cancelAction];
    [self.navigationController presentViewController:alertCon animated:YES completion:nil];
}
/**
 *  打开相机
 */
- (void)openCamera
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}
/**
 *  打开相册
 */
- (void)openPhotoLibrary
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}


#pragma mark 添加照片
- (void)addExpImage:(UIImage *)image
{
    SXQExpStep *step = self.currentStep;
    if (step.images.count > 9) {
        [MBProgressHUD showError:@"最多可添加9张"];
        return;
    }
    [step addImage:image myExpId:_experimentModel.myExpID];
}
#pragma mark 添加评论
- (void)addRemark:(void (^)())completion
{
    SXQExpStep *step = nil;
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    if (indexPath) {
        step = _currentExperimentData.expProcesses[indexPath.row];
    }else
    {
        [MBProgressHUD showError:@"请选择实验步骤"];
        return;
    }
    void (^addRemarkBlk)(NSString *remark) = ^(NSString *remark){
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    };
    SXQRemarkController *remarkVC = [[SXQRemarkController alloc] initWithExperimentStep:step];
    remarkVC.addRemarkBlk = addRemarkBlk;
    remarkVC.completion = completion;
    SXQNavgationController *nav = [[SXQNavgationController alloc] initWithRootViewController:remarkVC];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SXQExpStepFrame *stepFrame = _stepsDataSource.items[indexPath.row];
    return stepFrame.cellHeight;
}
- (void)binding
{
    [RACObserve(self, currentStep)
     subscribeNext:^(SXQExpStep *step) {
         _toolBar.currentStep = _currentStep;
     }];
    @weakify(self)
   [[[[[[[[[[_toolBar.starBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
       flattenMap:^RACStream *(id value) {
        @strongify(self)
         return [self isChoosingSignal];
     }]
       filter:^BOOL(NSNumber *ischosing) {
        return [ischosing boolValue];
    }]
       flattenMap:^RACStream *(id value) {
        @strongify(self)
        return [self isTimingSignal];
    }]
      
      filter:^BOOL(NSNumber *isTiming) {
          if (![isTiming boolValue]) {//没有在计时，开启计时器
              self.currentStep.isUserTimer = YES;
          }else
          {//正在计时，暂停计时器
              self.currentStep.isUserTimer = NO;
          }
         return [isTiming boolValue];
     }]
      flattenMap:^RACStream *(id value) {
         @strongify(self)
         return [self suspendTimerSignal];
     }]
      filter:^BOOL(NSNumber *isSuspend) {
          if ([isSuspend boolValue]) {//确定暂停计时器
              self.currentStep.isUserTimer = NO;
          }else
          {
              self.currentStep.isUserTimer = YES;
          }
         return [isSuspend boolValue];
     }]
    flattenMap:^RACStream *(id value) {
        @strongify(self)
        return [self isAddReagentLocation];
    }]
    filter:^BOOL(NSNumber *isAdd) {
        return [isAdd boolValue];
    }]
     subscribeNext:^(id value) {
         @strongify(self)
         [self addReagentLocation];
    }];
}
- (void)addReagentLocation
{
    NSLog(@"试剂已保存");
}
- (RACSignal *)isChoosingSignal
{
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)
        if ([self currentStep] == nil) {
            [MBProgressHUD showError:@"请选择试验步骤!"];
        }
        [subscriber sendNext:@([self currentStep] != nil)];
        [subscriber sendCompleted];
        return nil;
    }];
}
- (RACSignal *)isTimingSignal
{
    SXQExpStep *step = [self currentStep];
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@(step.isUserTimer)];
        [subscriber sendCompleted];
        return nil;
    }];
}
- (RACSignal *)suspendTimerSignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"暂停在此步骤" message:self.currentStep.expStepDesc preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [subscriber sendNext:@(YES)];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [subscriber sendNext:@(NO)];
        }];
        [alertVC addAction:action];
        [alertVC addAction:cancelAction];
        [self presentViewController:alertVC animated:YES completion:^{
        }];
        return nil;
    }];
}
- (RACSignal *)isAddReagentLocation
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        UIAlertController *remarkAlerVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *saveReagentAction = [UIAlertAction actionWithTitle:@"添加试剂保存位置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [subscriber sendNext:@(YES)];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [subscriber sendNext:@(NO)];
        }];
        [remarkAlerVC addAction:saveReagentAction];
        [remarkAlerVC addAction:cancelAction];
        [self.navigationController presentViewController:remarkAlerVC animated:YES completion:^{
        }];
        return nil;
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.currentStep = _currentExperimentData.expProcesses[indexPath.row];
}
@end