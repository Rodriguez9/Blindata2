//
//  Bucket.m
//  Blindata
//
//  Created by YZH on 2018/7/29.
//  Copyright © 2018年 YZH. All rights reserved.
//

#import "Bucket.h"
//私有
@interface Bucket()
@property(nonatomic,strong)NSMutableDictionary *data;
@end

@implementation Bucket

-(instancetype)init{
    if (self=[super init]) {
        self.data = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void)bucketInWithWithKey:(NSString *)key value:(NSObject *)value{
    _data[key]=value;
}

//取出再删除
-(NSObject *)bucketOutWithKey:(NSString *)key{
    NSObject *value = _data[key];
    [_data removeObjectForKey:key];
    return value;
}

//查询
-(NSObject *)valueForKey:(NSString *)key{
    return _data[key];
}

@end
