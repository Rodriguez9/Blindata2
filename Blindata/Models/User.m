//
//  User.m
//  Blindata
//
//  Created by YZH on 2018/8/14.
//  Copyright © 2018年 YZH. All rights reserved.
//

#import "User.h"

static BOOL _loaded= NO;
static User *_instance = nil;

@implementation User

+ (instancetype)currentUser{
    if (!_loaded) {
        _instance = [NSKeyedUnarchiver unarchiveObjectWithFile:[self filePath]];
        _loaded = YES;
    }
    return _instance;
}

+(void)loginWithID:(NSString *)object username:(NSString *)username{
    _instance = [[User alloc] initWithID:object username:username];
    [NSKeyedArchiver archiveRootObject:_instance toFile:[self filePath]];
    _loaded = YES;
}

+(void)loginout{
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager removeItemAtPath:[self filePath] error:nil];
    _instance = nil ;
    _loaded = YES;
}

#pragma mark - NSCoding

//编码
-(void)encodeWithCoder:(NSCoder *)coder{
    [coder encodeObject:_objectId forKey:@"objectId"];
    [coder encodeObject:_username forKey:@"username"];
}

//解码
-(instancetype)initWithCoder:(NSCoder *)coder{
    if (self = [super init]) {
        _objectId=[coder decodeObjectForKey:@"objectId"];
        _username=[coder decodeObjectForKey:@"username"];
    }
    return self;
}

#pragma mark - Private

-(instancetype)initWithID:(NSString *)objectId username:(NSString *)username{
    if (self=[super init]) {
        self.objectId = objectId;
        self.username = username;
    }
    return self;
}

+(NSString *)filePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    return [paths[0] stringByAppendingPathComponent:@"user"];
}

@end
