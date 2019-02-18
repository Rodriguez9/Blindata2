//
//  UIColor+Int.m
//  Blindata
//
//  Created by YZH on 2018/9/3.
//  Copyright © 2018年 YZH. All rights reserved.
//

#import "UIColor+Int.h"

@implementation UIColor (Int)

+(UIColor *)colorWithComponent:(NSInteger)component alaph:(NSInteger)alaph{
    CGFloat w = component / 255.0;
    CGFloat a = alaph / 255.0;
    return [UIColor colorWithComponent:w alaph:a];
}

+(UIColor *)colorWithComponent:(NSInteger)component{
    return [self colorWithComponent:component alaph:255];
}

+(UIColor *)colorWithR:(NSInteger)red G:(NSInteger)green B:(NSInteger)blue A:(NSInteger)alaph{
    CGFloat r = red / 255.0;
    CGFloat g = green / 255.0;
    CGFloat b = blue / 255.0;
    CGFloat a = alaph / 255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:a];
}

+(UIColor *)colorWithR:(NSInteger)r G:(NSInteger)g B:(NSInteger)b{
    return [self colorWithR:r G:g B:b A:255];
}

+(UIColor *)colorWithHex:(NSInteger)hex{
    NSInteger r = (hex & 0xFF0000) >>16;
    NSInteger g = (hex & 0xFF00) >>8;
    NSInteger b = hex & 0xFF;
    return [UIColor colorWithR:r G:g B:b];
}

@end
