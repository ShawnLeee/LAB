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
#import "TimeRecorder.h"
#import "SXQExpStep.h"
#import "SXQCurrentExperimentData.h"
#import "SXQExperimentModel.h"

@interface SXQCurrentExperimentController ()<UITableViewDelegate,SXQExperimentToolBarDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,TimeRecorderDelegate>
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
@property (nonatomic,weak) TimeRecorder *timer;
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
- (SXQExpStep *)currentStep
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    if (indexPath) {
        _currentStep = _currentExperimentData.expProcesses[indexPath.row];
        return _currentStep;
    }else
    {
        return nil;
    }
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
         _stepsDataSource.items = [tmp copy];
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
    self.navigationItem.leftBarButtonItem = [self leftBarButton];
}
- (UIBarButtonItem *)leftBarButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.frame = CGRectMake(0, 0, 40, 30);
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if(_timer)
        {
            [self closeTimer:^(BOOL cancelTimer) {
                if (cancelTimer) {
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];    
        }else
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
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
                    TimeRecorder *recorder = [TimeRecorder showTimer];
                    recorder.delegate = self;
                    _timer = recorder;    
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
#pragma mark timer delegate method 
- (void)timeRecorderdidCancel:(TimeRecorder *)timeRecorder
{
    [self closeTimer:nil];
}
- (void)closeTimer:(void (^)(BOOL cancelTimer))completion
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"关闭计时器" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [UIView animateWithDuration:0.5 animations:^{
                _timer.alpha = 0;
            } completion:^(BOOL finished) {
                [_timer removeFromSuperview];
                if(completion)
                {
                    completion(YES);
                }
            }];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if(completion)
            {
                completion(NO);
            }
        }];
        [alertVC addAction:action];
        [alertVC addAction:cancelAction];
        [self presentViewController:alertVC animated:YES completion:^{
            
        }];
}
- (void)timeRecorderdidPaused:(TimeRecorder *)timeRecorder
{
    if (self.currentStep) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"暂停在此步骤" message:self.currentStep.expStepDesc preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self addRemarkWithConfirm];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [_timer startTimer];
        }];
        [alertVC addAction:action];
        [alertVC addAction:cancelAction];
        [self presentViewController:alertVC animated:YES completion:^{
        }];    
    }
    
}
- (void)addRemarkWithConfirm
{
    UIAlertController *remarkAlerVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *saveReagentAction = [UIAlertAction actionWithTitle:@"添加试剂保存位置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _timer.hidden = YES;
        __block TimeRecorder *timer = _timer;
        SXQSaveReagentController *reagentVC = [[SXQSaveReagentController alloc] initWithExperimentStep:self.currentStep completion:^{
            timer.hidden = NO;
#warning Save current step reagent place
            SXQExperimentStep *step = self.currentStep;
        }];
        SXQNavgationController *nav =  [[SXQNavgationController alloc] initWithRootViewController:reagentVC];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }];
//    UIAlertAction *addRemarkAction = [UIAlertAction actionWithTitle:@"添加备注" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        _timer.hidden = YES;
//        __block TimeRecorder *timer = _timer;
//        [self addRemark:^{
//            timer.hidden = NO;
//        }];
//    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [remarkAlerVC addAction:saveReagentAction];
//    [remarkAlerVC addAction:addRemarkAction];
    [remarkAlerVC addAction:cancelAction];
    [self.navigationController presentViewController:remarkAlerVC animated:YES completion:^{
        
    }];
}
- (void)timeRecorder:(TimeRecorder *)timeRecorder finishedTimerWithTime:(NSTimeInterval)countTime
{
    
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
         return [isTiming boolValue];
     }]
      flattenMap:^RACStream *(id value) {
         @strongify(self)
         return [self suspendTimerSignal];
     }]
      filter:^BOOL(NSNumber *isSuspend) {
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
        if (step.isUserTimer) {
            //询问是否暂停计时器，添加试剂保存位置
        }else
        {
            //开启计时器
            step.isUserTimer = YES;
            NSLog(@"开启计时器！！！！");
        }
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
@end