//
//  SXQInstructionHeader.h
//  实验助手
//
//  Created by SXQ on 15/8/30.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
@class SXQInstructionHeader;
#import <UIKit/UIKit.h>

@protocol SXQInstructionHeaderDelegate <NSObject>
@optional
- (void)didSelectedInstructionHeader:(SXQInstructionHeader *)header;
@end

@interface SXQInstructionHeader : UITableViewHeaderFooterView
@property (nonatomic,copy) NSString *groupTitle;
@property (nonatomic,weak) id<SXQInstructionHeaderDelegate> delegate;
@end

