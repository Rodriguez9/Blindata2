//
//  UIHelper.h
//  Blindata
//
//  Created by YZH on 2018/9/3.
//  Copyright © 2018年 YZH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD.h>//网络请求加载动画

@interface UIHelper : NSObject

+(void)showLoadingInView:(UIView *)view hasText:(BOOL)hasText;
+(void)showLoadingInView:(UIView *)view;
+(void)dismissLoadingView:(UIView *)view;
+(void)showTipsWithText:(NSString *)text inView:(UIView *)view;
+(void)showErrorWithText:(NSString *)text inView:(UIView *)view;

@end
