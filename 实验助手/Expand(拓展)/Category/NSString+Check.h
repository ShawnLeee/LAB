//
//  NSString+Check.h
//  邻医家
//
//  Created by SXQ on 15/7/27.
//  Copyright (c) 2015年 DanielGrason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Check)
- (BOOL)dg_isPhoneNumber;
- (BOOL)dg_isNumber;
- (BOOL)dg_isValidMailbox;
- (BOOL)dg_isValidIdentity;
- (BOOL)dg_isValidPassword;
@end
