//
//  UIHelper.m
//  Blindata
//
//  Created by YZH on 2018/9/3.
//  Copyright © 2018年 YZH. All rights reserved.
//

#import "UIHelper.h"
#import "UIColor+Int.h"

@implementation UIHelper

+(void)showLoadingInView:(UIView *)view hasText:(BOOL)hasText{
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    UIView *container = (view != nil ? view : window);
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:container animated:YES];
    hub.color = [UIColor colorWithHex:0xd78b93];
    if (hasText) {
        hub.labelText = @"加载中";
    }
}

+(void)showLoadingInView:(UIView *)view{
    [self showLoadingInView:view hasText:NO];
}

+(void)dismissLoadingView:(UIView *)view{
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    UIView *container = (view != nil ? view : window);
    [MBProgressHUD hideHUDForView:container animated:YES];
}

//显示提示文字
+(void)showTipsWithText:(NSString *)text inView:(UIView *)view{
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    UIView *container = (view != nil ? view : window);
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:container animated:YES];
    
    hub.color = [UIColor colorWithHex:0xd78b93];
    hub.mode = MBProgressHUDModeCustomView;
    hub.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"info"]];
    hub.detailsLabelFont = [UIFont boldSystemFontOfSize:16];
    hub.detailsLabelText = text;
    
    [hub hide:YES afterDelay:1.5];
}

+(void)showErrorWithText:(NSString *)text inView:(UIView *)view{
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    UIView *container = (view != nil ? view : window);
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:container animated:YES];
    
    hub.color = [UIColor colorWithHex:0xd78b93];
    hub.mode = MBProgressHUDModeCustomView;
    hub.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"error"]];
    hub.detailsLabelFont = [UIFont boldSystemFontOfSize:16];
    hub.detailsLabelText = text;
    
    [hub hide:YES afterDelay:1.5];
}

@end
