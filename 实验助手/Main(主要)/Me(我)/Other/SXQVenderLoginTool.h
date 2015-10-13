//
//  SXQVenderLoginTool.h
//  实验助手
//
//  Created by sxq on 15/9/11.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, VenderLoginType) {
    VenderLoginTypeWeibo,
    VenderLoginTypeWeChat,
    VenderLoginTypeQQ,
};

typedef void (^LoginCompletionBlk)(BOOL success) ;

@interface SXQVenderLoginTool : NSObject
+ (void)venderLoginWithLoginType:(VenderLoginType)loginType completion:(LoginCompletionBlk)completion;
@end
