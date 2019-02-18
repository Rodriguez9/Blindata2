//
//  User.h
//  Blindata
//
//  Created by YZH on 2018/8/14.
//  Copyright © 2018年 YZH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject<NSCoding>

@property (nonatomic,strong) NSString *objectId;
@property (nonatomic,strong) NSString *username;

+ (instancetype)currentUser;
+ (void)loginWithID:(NSString *)object username:(NSString *)username;;
+ (void)loginout;

@end
