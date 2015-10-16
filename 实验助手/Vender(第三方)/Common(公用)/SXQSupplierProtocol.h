//
//  SXQSupplierProtocol.h
//  实验助手
//
//  Created by sxq on 15/10/16.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class SXQSupplier;
#import <Foundation/Foundation.h>
@protocol SXQSupplierProcotol <NSObject>
@required
- (SXQSupplier *)fetchSupplier;
- (void)updateSupplier:(SXQSupplier *)supplier;
- (NSArray *)totalSuppliers;
@end