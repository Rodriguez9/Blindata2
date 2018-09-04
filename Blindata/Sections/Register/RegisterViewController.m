//
//  RegisterViewController.m
//  Blindata
//
//  Created by YZH on 2018/9/3.
//  Copyright © 2018年 YZH. All rights reserved.
//

#import "RegisterViewController.h"
#import "VerifyHelper.h"
#import "UIHelper.h"
#import "AFNetworkingHelper.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

//点击空白处时，结束编辑状态
-(IBAction)touched{
    [self.view endEditing:YES];
}

-(IBAction)registerButtonPress:(id)sender{
    if ([self verify]) {
        [UIHelper showLoadingInView:self.view];
        NSString *username = [_fileIds[0] text];
        NSString *password = [_fileIds[1] text];
        NSDictionary *params = @{@"username":username,@"password":password};
        AFNetworkingHelper *helper = [AFNetworkingHelper defaultHelper];
        [helper sendRequestWithURLString:KURLTypeRegister parameter:params success:^(NSURLSessionDataTask *task,NSDictionary *response){
            [UIHelper dismissLoadingView:self.view];
            [self successWithTask:task response:response];
            } failure:^(NSURLSessionDataTask *task,NSError *error){
                [UIHelper dismissLoadingView:self.view];
                [self failureWithTask:task error:error];
            }];
    }
}

-(IBAction)textFieldDidEndOnExit:(UITextField *)field{
    NSInteger index = [_fileIds indexOfObject:field];
    if (index<2) {
        //resignFirstResponder:通知接收方已经要求它在窗口中放弃其作为第一响应者的状态
        [field resignFirstResponder];
        //becomeFirstResponder:要求UIKit将此对象作为其窗口中的第一个响应者
        [_fileIds[++index] becomeFirstResponder];
    }else{
        [field resignFirstResponder];
    }
}

#pragma mark - Private

//验证
-(BOOL)verify{
    //
    NSString *name = [_fileIds[0] text];
    if ([VerifyHelper isEmptyString:name]) {
        [UIHelper showTipsWithText:@"请输入用户名" inView:self.view];
        return NO;
    }
    
    //
    NSString *password = [_fileIds[1] text];
    if ([VerifyHelper isEmptyString:password]) {
        [UIHelper showTipsWithText:@"请输入密码" inView:self.view];
        return NO;
    }
    
    //
    NSString *passwordAgain = [_fileIds[2] text];
    if ([VerifyHelper isEmptyString:passwordAgain]) {
        [UIHelper showTipsWithText:@"请再次输入密码" inView:self.view];
        return NO;
    }
    
    if (![password isEqualToString:passwordAgain]) {
        [UIHelper showTipsWithText:@"两次输入密码不一致" inView:self.view];
        return NO;
    }
    return YES;
}

-(void)successWithTask:(NSURLSessionTask *)task response:(NSDictionary *)response{
    NSInteger code = [response[@"code"] integerValue];
    if (code == 200) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        NSString *text = response[@"msg"];
        [UIHelper showTipsWithText:text inView:self.view];
    }
}

-(void)failureWithTask:(NSURLSessionTask *)task error:(NSError *)error{
    [UIHelper showErrorWithText:@"网络异常，请重新尝试" inView:self.view];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
