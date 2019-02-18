//
//  VerifyHelper.m
//  Blindata
//
//  Created by YZH on 2018/9/3.
//  Copyright © 2018年 YZH. All rights reserved.
//

#import "VerifyHelper.h"

@implementation VerifyHelper

//判断字符串是否为空
+(BOOL)isEmptyString:(NSString *)string{
    if (string == nil) {
        return YES;
    }
    if ([string isKindOfClass:NSNull.class]) {
        return YES;
    }
    
    NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
    //把前后空格去掉
    NSString *result = [string stringByTrimmingCharactersInSet:set];
    if (result.length == 0) {
        return YES;
    }
    return NO;
}

@end
