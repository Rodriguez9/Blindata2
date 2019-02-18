//
//  AFNetworkingHelper.h
//  Blindata
//
//  Created by YZH on 2018/8/8.
//  Copyright © 2018年 YZH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLMacro.h"
#import <AFNetworking.h>
@interface AFNetworkingHelper : NSObject

+(instancetype)defaultHelper;

-(void)sendRequestWithURLString:(NSString *)urlString
                      parameter:(NSDictionary *)parameter
                        success:(void (^)(NSURLSessionDataTask *,id))success
                        failure:(void (^)(NSURLSessionDataTask *,NSError *))failure
                          cache:(BOOL)useCache;

-(void)sendRequestWithURLString:(NSString *)urlString
                      parameter:(NSDictionary *)parameter
                        success:(void (^)(NSURLSessionDataTask *, id))success
                        failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

-(void)sendRequestWithURLString:(NSString *)urlString
                        success:(void (^)(NSURLSessionDataTask *,id))success
                        failure:(void (^)(NSURLSessionDataTask *,NSError *))failure
                          cache:(BOOL)useCache;

-(void)sendRequestWithURLString:(NSString *)urlString
                        success:(void (^)(NSURLSessionDataTask *,id))success
                        failure:(void (^)(NSURLSessionDataTask *,NSError *))failure;

-(void)uploadWithURLString:(NSString *)urlString
                           data:(NSData *)data
                        success:(void (^)(NSURLSessionDataTask *,id))success
                        failure:(void (^)(NSURLSessionDataTask *,NSError *))failure;

@end
