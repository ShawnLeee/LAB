//
//  SXQHttpTool.m
//  SXQMovie
//
//  Created by Daniel on 15/8/12.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
#import <AFNetworking.h>
#import "SXQHttpTool.h"

@implementation SXQHttpTool
//+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure
//{
//    //1.创建请求管理对象
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//#warning 编码问题
//    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    //    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    //2.发送请求
//    [manager POST:url
//       parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
//     {
//         for (LDFormData *ldformData in formDataArray) {
//             [formData appendPartWithFileData:ldformData.data name:ldformData.name fileName:ldformData.filename mimeType:ldformData.mimiType];
//         }
//     }
//          success:^(AFHTTPRequestOperation *operation, id responseObject)
//     {
//         if (success) {
//             success(responseObject);
//         }
//     }
//          failure:^(AFHTTPRequestOperation *operation, NSError *error)
//     {
//         if (failure) {
//             failure(error);
//         }
//     }];
//}
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    //1.创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //2.发送请求
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    //1.创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //2.发送请求
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
