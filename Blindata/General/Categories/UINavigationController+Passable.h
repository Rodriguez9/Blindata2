//
//  UINavigationController+Passable.h
//  Blindata
//
//  Created by YZH on 2018/7/29.
//  Copyright © 2018年 YZH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Passable)

-(void)pushViewControllerWithStoryboardID:(NSString *)identifier
                                 animated:(BOOL)animated
                                      tag:(NSString *)tag
                                     data:(NSObject *)data;

-(UIViewController *)popViewControllerAnimated:(BOOL)animated
                                           tag:(NSString *)tag
                                          data:(NSObject *)data;

-(NSArray *)popToRootViewControllerAnimated:(BOOL)animated
                                        tag:(NSString *)tag
                                       data:(NSObject *)data;

-(void)pushViewControllerWithStoryboardID:(NSString *)identifier
                                 animated:(BOOL)animated
                                     data:(NSObject *)data;

-(UIViewController *)popViewControllerAnimated:(BOOL)animated
                                          data:(NSObject *)data;

-(NSArray *)popToRootViewControllerAnimated:(BOOL)animated
                                       data:(NSObject *)data;
@end
