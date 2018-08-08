//
//  UIViewController+Base.m
//  Blindata
//
//  Created by YZH on 2018/6/12.
//  Copyright © 2018年 YZH. All rights reserved.
//

#import "UIViewController+Base.h"

@implementation UIViewController (Base)

-(SLiderMenuViewController *)slideMenuController{
    UIViewController *controller = self.parentViewController;
    while (controller != nil) {
        if (controller.class==SLiderMenuViewController.class) {
            return (SLiderMenuViewController *)controller;
        }else{
            controller=controller.parentViewController;
        }
    }
    return nil;
}
- (IBAction)test:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
