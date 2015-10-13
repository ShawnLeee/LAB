//
//  DWActionSheet.m
//  实验助手
//
//  Created by sxq on 15/9/24.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "DWActionSheet.h"
#import "DWInstructionActionView.h"
#import "DWActionButton.h"
static CGFloat kAcitonViewHeight = 130;
@interface DWActionSheet ()
@property (nonatomic,strong) DWInstructionActionView *actionView;
@end
@implementation DWActionSheet
- (instancetype)init
{
    if (self = [super init]) {
        CGRect screenRect = [UIScreen mainScreen].bounds;
        self.frame = screenRect;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        DWInstructionActionView *actionView = [[DWInstructionActionView alloc] initWithFrame:CGRectMake(0, screenRect.size.height , screenRect.size.width, kAcitonViewHeight)];
        [actionView.cancelButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:actionView];
        _actionView = actionView;
        [self setupButtons];
    }
    return self;
}
- (instancetype)initWithHandler:(Handler)handler
{
    self = [self init];
    _handler = [handler copy];
    return self;
}
- (void)setupButtons
{
    [self setupButton:_actionView.editButton withButtonType:DWActionButtonTypeEdit];
    [self setupButton:_actionView.uploadButton withButtonType:DWActionButtonTypeUpload];
    [self setupButton:_actionView.cacheButton withButtonType:DWActionButtonTypeCache];
    [self setupButton:_actionView.retweatButton withButtonType:DWActionButtonTypeRetreat];
}
- (void)setupButton:(DWActionButton *)button withButtonType:(DWActionButtonType)type
{
    button.tag = type;
    [button addTarget:self action:@selector(butttonTapped:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)butttonTapped:(DWActionButton *)button
{
    _handler(button.tag);
}
- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.5 animations:^{
        _actionView.transform = CGAffineTransformMakeTranslation(0, -kAcitonViewHeight);
    }];
}
- (void)hide
{
    [UIView animateWithDuration:0.5 animations:^{
        _actionView.transform = CGAffineTransformIdentity;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
