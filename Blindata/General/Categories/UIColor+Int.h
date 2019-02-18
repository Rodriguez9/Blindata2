//
//  UIColor+Int.h
//  Blindata
//
//  Created by YZH on 2018/9/3.
//  Copyright © 2018年 YZH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Int)

+(UIColor *)colorWithComponent:(NSInteger)component alaph:(NSInteger)alaph;
+(UIColor *)colorWithComponent:(NSInteger)component;
+(UIColor *)colorWithR:(NSInteger)r G:(NSInteger)g B:(NSInteger)b A:(NSInteger)a;
+(UIColor *)colorWithR:(NSInteger)r G:(NSInteger)g B:(NSInteger)b;
+(UIColor *)colorWithHex:(NSInteger)hex;

@end
