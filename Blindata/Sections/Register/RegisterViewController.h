//
//  RegisterViewController.h
//  Blindata
//
//  Created by YZH on 2018/9/3.
//  Copyright © 2018年 YZH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController
//输出口数组
@property(nonatomic,strong)IBOutletCollection(UITextField) NSArray *fileIds;

@end
