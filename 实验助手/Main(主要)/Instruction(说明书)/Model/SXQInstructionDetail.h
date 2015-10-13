//
//  SXQInstructionDetail.h
//  实验助手
//
//  Created by sxq on 15/9/23.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXQInstructionDetail : NSObject
@property (nonatomic,copy) NSString *expInstructionID;
@property (nonatomic,copy) NSString *experimentDesc;
@property (nonatomic,copy) NSString *experimentName;
@property (nonatomic,copy) NSString *experimentTheory;
@property (nonatomic,copy) NSString *instructState;
@property (nonatomic,copy) NSString *productNum;
@property (nonatomic,strong) NSArray *steps;
@property (nonatomic,copy) NSString *supplierName;
@end
