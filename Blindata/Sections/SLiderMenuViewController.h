//
//  SLiderMenuViewController.h
//  Blindata
//
//  Created by YZH on 2018/3/17.
//  Copyright © 2018年 YZH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLiderMenuViewController : UIViewController
@property(nonatomic,weak)IBOutlet UIPanGestureRecognizer *pan;
- (void)switchController;
@end
