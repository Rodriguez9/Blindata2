//
//  HomeViewController.m
//  Blindata
//
//  Created by YZH on 2018/3/17.
//  Copyright © 2018年 YZH. All rights reserved.
//

#import "HomeViewController.h"
#import "UIViewController+Base.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NavigationHelper *Helper = [NavigationHelper defaultHelper];
    self.navigationController.delegate = Helper;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.slideMenuController.pan.enabled=YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.slideMenuController.pan.enabled=NO;
}

- (IBAction)testButtonPressed:(UIButton *)sender {
    [self.slideMenuController switchController];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
