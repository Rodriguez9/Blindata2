//
//  Bucket.h
//  Blindata
//
//  Created by YZH on 2018/7/29.
//  Copyright © 2018年 YZH. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kBucketKeyTypeTag @"kBucketDataKeyTypeTag"
#define kBucketKeyTypeData @"kBucketDataKeyTypeTypeData"

@interface Bucket : NSObject
//instancetype当前所在类的类型
-(instancetype)init;
//数据存入库
-(void)bucketInWithWithKey:(NSString *)key value:(NSObject *)value;
//存储桶
-(NSObject *)bucketOutWithKey:(NSString *)key;
//取键值
-(NSObject *)valueForKey:(NSString *)key;

@end
