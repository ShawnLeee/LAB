//
//  SXQSupplier.h
//  实验助手
//
//  Created by sxq on 15/10/9.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXQSupplier : NSObject
@property (nonatomic,copy) NSString *supplierID;
@property (nonatomic,copy) NSString *supplierName;
@property (nonatomic,assign) int supplierType;
@property (nonatomic,copy) NSString *contacts;
@property (nonatomic,copy) NSString *telNo;
@property (nonatomic,copy) NSString *mobilePhone;
@property (nonatomic,copy) NSString *eMail;
@property (nonatomic,copy) NSString *address;
@end
