//
//  SXQSegmentedControl.h
//  实验助手
//
//  Created by SXQ on 15/8/31.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SXQSegmentedControl : UIView
@property(nonatomic) NSInteger selectedSegmentIndex;
- (instancetype)initWithItems:(NSArray *)items;
@end
