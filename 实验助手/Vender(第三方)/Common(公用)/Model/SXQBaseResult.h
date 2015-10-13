//
//  SXQBaseResult.h
//  实验助手
//
//  Created by sxq on 15/9/21.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXQBaseResult : NSObject
@property (nonatomic,copy) NSString *code;
@property (nonatomic,copy) NSString *msg;
@property (nonatomic,strong) NSArray *data;
+ (NSDictionary *)objectClassInArray;
@end
