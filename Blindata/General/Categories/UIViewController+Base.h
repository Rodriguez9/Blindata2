//
//  UIViewController+Base.h
//  Blindata
//
//  Created by YZH on 2018/6/12.
//  Copyright © 2018年 YZH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLiderMenuViewController.h"
#import "NavigationHelper.h"
#import "Passable.h"
#import "UINavigationController+Passable.h"
@interface UIViewController (Base)

@property (nonatomic,readonly) SLiderMenuViewController *slideMenuController;

@end
