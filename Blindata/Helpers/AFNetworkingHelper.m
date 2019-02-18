//
//  AFNetworkingHelper.m
//  Blindata
//
//  Created by YZH on 2018/8/8.
//  Copyright © 2018年 YZH. All rights reserved.
//

#import "AFNetworkingHelper.h"

static AFNetworkingHelper *instance = nil;

@interface AFNetworkingHelper ()

@property(nonatomic,strong) AFHTTPSessionManager *manager;

@end

@implementation AFNetworkingHelper

+(instancetype)defaultHelper{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        instance = [[super allocWithZone:NULL] init];
        [instance initialization];
    });
    return instance;
}

+(id)allocWithZone:(struct _NSZone *)zone{
    return [AFNetworkingHelper defaultHelper];
}

-(id)copyWithZone:(struct _NSZone *)zone{
    return [AFNetworkingHelper defaultHelper];
}

#pragma mark - HTTP

-(void)sendRequestWithURLString:(NSString *)urlString
                      parameter:(NSDictionary *)parameter
                        success:(void (^)(NSURLSessionDataTask *,id))success
                        failure:(void (^)(NSURLSessionDataTask *,NSError *))failure
                          cache:(BOOL)useCache{
    if (useCache == YES) {
        _manager.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    }else{
        _manager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    }
    if (parameter != nil) {
        [_manager POST:urlString parameters:parameter progress:nil
            success:^ (NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject){
                @try {
                    success(task,responseObject);
                }@catch(NSException *exception){
                    NSLog(@"[%@]throws exception:%@",NSStringFromSelector(_cmd),exception);
                }
            }
            failure:^(NSURLSessionDataTask *_Nullable task,NSError *_Nonnull error){
                   @try{
                       failure(task,error);
                   }@catch(NSException *exception){
                       NSLog(@"[%@]throws exception:%@",NSStringFromSelector(_cmd),exception);
                   }
            }];
    }else{
        [_manager GET:urlString parameters:parameter progress:nil
              success:^ (NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject){
                    @try{
                        success(task,responseObject);
                    }@catch(NSException *exception){
                        //cmd当前方法
                        NSLog(@"[%@]throws exception:%@",NSStringFromSelector(_cmd),exception);
                    }
              }
              failure:^(NSURLSessionDataTask * _Nonnull task, NSError *_Nullable error){
                  @try{
                      failure(task,error);
                  }@catch(NSException *exception){
                      NSLog(@"[%@]throws exception:%@",NSStringFromSelector(_cmd),exception);
                  }
            }];
    }
}

-(void)sendRequestWithURLString:(NSString *)urlString
                      parameter:(NSDictionary *)parameter
                        success:(void (^)(NSURLSessionDataTask *, id))success
                        failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    [self sendRequestWithURLString:urlString parameter:parameter success:success failure:failure cache:NO];
}

-(void)sendRequestWithURLString:(NSString *)urlString
                        success:(void (^)(NSURLSessionDataTask *,id))success
                        failure:(void (^)(NSURLSessionDataTask *,NSError *))failure
                          cache:(BOOL)useCache{
    [self sendRequestWithURLString:urlString success:success failure:failure cache:useCache];
}

-(void)sendRequestWithURLString:(NSString *)urlString
                        success:(void (^)(NSURLSessionDataTask *,id))success
                        failure:(void (^)(NSURLSessionDataTask *,NSError *))failure{
    [self sendRequestWithURLString:urlString success:success failure:failure cache:NO];
}

-(void)uploadWithURLString:(NSString *)urlString
                      data:(NSData *)data
                   success:(void (^)(NSURLSessionDataTask *,id))success
                   failure:(void (^)(NSURLSessionDataTask *,NSError *))failure{
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //
    [request addValue:@"b21fbd9b0ce4879dc618f6f685c223e0" forHTTPHeaderField:@"X-Bmob-Application-Id"];
    [request addValue:@"8f397fe28f5e02d316d9af109b3fcdc9" forHTTPHeaderField:@"X-Bmob-REST-API-Key"];
    [request addValue:@"image/jpeg" forHTTPHeaderField:@"Content-Type"];
    
    //
    [request setHTTPBody:data];
    [request setHTTPMethod:@"POST"];
    
    //
    NSURLSessionDataTask *task = [_manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *respone, id object,NSError *error){
        @try{
            if (error != nil) {
                failure(respone,error);
            }else{
                success(respone,object);
            }
        }@catch(NSException *exception){
            NSLog(@"throw exception:%@",exception);
        }
    }];
    [task resume];
}

#pragma mark - Private

-(void)initialization{
    self.manager = [AFHTTPSessionManager manager];
}

@end
