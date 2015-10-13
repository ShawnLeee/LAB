//
//  SXQHttpTool.h
//  SXQMovie
//
//  Created by Daniel on 15/8/12.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXQHttpTool : NSObject
//+ (void)postWithURL:(NSString *)url
//             params:(NSDictionary *)params
//      formDataArray:(NSArray *)formDataArray
//            success:(void (^)(id json))success
//            failure:(void (^)(NSError *error))failure;
+ (void)getWithURL:(NSString *)url
            params:(NSDictionary *)params
           success:(void (^)(id json))success
           failure:(void (^)(NSError *error))failure;
+ (void)postWithURL:(NSString *)url
             params:(NSDictionary *)params
            success:(void (^)(id json))success
            failure:(void (^)(NSError *error))failure;
@end
