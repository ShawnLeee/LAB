//
//  DWActionSheet.h
//  实验助手
//
//  Created by sxq on 15/9/24.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class DWActionSheet;
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,DWActionButtonType){
    DWActionButtonTypeEdit,
    DWActionButtonTypeUpload,
    DWActionButtonTypeCache,
    DWActionButtonTypeRetreat,
};
typedef void (^Handler)(DWActionButtonType buttonType);
@interface DWActionSheet : UIView
- (instancetype)initWithHandler:(Handler)handler;
- (void)show;
@property (nonatomic,copy) Handler handler;
@end
