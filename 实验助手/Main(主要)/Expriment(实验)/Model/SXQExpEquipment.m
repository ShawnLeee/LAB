//
//  SXQExpEquipment.m
//  实验助手
//
//  Created by sxq on 15/10/9.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "SXQExpEquipment.h"

@implementation SXQExpEquipment
- (NSString *)fetchSupplier
{
    return self.supplier;
}
- (void)updateSupplier:(NSString *)supplier
{
    self.supplier = supplier;
}
- (NSArray *)totalSuppliers
{
    return self.suppliers;
}
@end
