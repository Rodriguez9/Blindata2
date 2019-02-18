//
//  NavigationHelper.h
//  Blindata
//
//  Created by YZH on 2018/7/29.
//  Copyright © 2018年 YZH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bucket.h"
@interface NavigationHelper : NSObject <UINavigationControllerDelegate>

@property(nonatomic,strong)Bucket *bucket;
+(instancetype)defaultHelper;

@end
