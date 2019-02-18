//
//  Passable.h
//  Blindata
//
//  Created by YZH on 2018/7/29.
//  Copyright © 2018年 YZH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Passable <NSObject>

@optional
//数据标签
- (void)viewControllerDidShowWithTag:(NSString *)tag data:(NSObject *)data;

@end
