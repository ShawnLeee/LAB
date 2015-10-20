//
//  NSString+Check.m
//  邻医家
//
//  Created by SXQ on 15/7/27.
//  Copyright (c) 2015年 DanielGrason. All rights reserved.
//

#import "NSString+Check.h"

@implementation NSString (Check)
- (BOOL)dg_isNumber
{
    NSString *tmpStr = self;
    tmpStr = [tmpStr stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if (tmpStr.length > 0) {
        return NO;
    }
    return YES;
}
- (BOOL)dg_isValidMailbox
{
    
    NSString *tmpStr = self;
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:tmpStr];
}
- (BOOL)dg_isPhoneNumber
{
    
    NSString *tmpStr = self;
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:tmpStr];
    return NO;
}
- (BOOL)dg_isValidIdentity
{
    
    NSString *tmpStr = self;
    BOOL flag;
    if (tmpStr.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:tmpStr];
    return NO;
}
- (BOOL)dg_isValidPassword
{
    if (self.length >= 6) {
        return YES;
    }
    return NO;
}
@end
