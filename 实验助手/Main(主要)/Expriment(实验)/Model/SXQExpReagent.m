//
//  SXQExpReagent.m
//  实验助手
//
//  Created by sxq on 15/9/30.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "SXQExpReagent.h"

@implementation SXQExpReagent
- (SXQSupplier *)fetchSupplier
{
    return self.finalSupplier;
}
- (void)updateSupplier:(SXQSupplier *)supplier
{
    self.finalSupplier = supplier;
}
- (NSArray *)totalSuppliers
{
    return self.suppliers;
}
@end
