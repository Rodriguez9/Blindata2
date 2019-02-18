//
//  UserViewController.m
//  Blindata
//
//  Created by YZH on 2018/3/17.
//  Copyright © 2018年 YZH. All rights reserved.
//

#import "UserViewController.h"
#import "UtilsMacro.h"
#import "User.h"
#import "AFNetworkingHelper.h"
#import <UIImageView+WebCache.h>
#import "UIViewController+Base.h"

@interface UserViewController ()

//是否登陆
@property(nonatomic,assign)BOOL logged;
//头像
@property(nonatomic,weak)IBOutlet UIImageView *headImageView;
//
@property(nonatomic,weak)IBOutlet UILabel *nicknameLabel;

@end

@implementation UserViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self registerNotification];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self unregisterNotification];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景图片
    UIImage *image = [UIImage imageNamed:@"menu_bg"];
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:image];
    
    //刷新数据
    User *user = [User currentUser];
    _logged = (user != nil ? YES : NO);
    [self refresh];
}

-(IBAction)headTapped{
    if (_logged == NO) {
        [self pushWithStoryboardID:@"Login" data:nil];
    }
}



#pragma mark - Private

-(void)registerNotification{
    //注册通知
    NSNotificationCenter *center =[NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(didLogin) name:KNotificationTypeLogin object:nil];
    [center addObserver:self selector:@selector(didReset) name:KNOfiticationTypeReset object:nil];
}

-(void)unregisterNotification{
     NSNotificationCenter *center =[NSNotificationCenter defaultCenter];
    [center removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didLogin{
    _logged = YES;
    [self refresh];
}

-(void)didReset{
    [self refresh];
}

-(void)refresh{
   if (_logged == YES) {
        NSString *objectId = [[User currentUser] objectId];
        NSDictionary *data = @{@"objectId":objectId};
       AFNetworkingHelper *helper = [AFNetworkingHelper defaultHelper];
       [helper sendRequestWithURLString:KURLTypeinfos
                              parameter:data
                                success:^(NSURLSessionDataTask *task, NSDictionary *response){
                                    [self successWithTask:task response:response];
                                }
                                failure:^(NSURLSessionDataTask *task,NSError *error){
                                    NSLog(@"%@",error);
                                    [self failureWithTask:task error:error];
                                }];
   } else {
       _headImageView.image = [UIImage imageNamed:@"default_user"];
       _nicknameLabel.text = @"点击头像登陆";
       [self.tableView reloadData];
   }
}

-(void)successWithTask:(NSURLSessionDataTask *)task response:(NSDictionary *)response{
    NSInteger code = [response[@"code"] integerValue];
    if (code == 200) {
        //设置昵称
        NSDictionary *data = response[@"data"];
        _nicknameLabel.text = data[@"nickname"];
        
        //设置头像
        NSString *photo = data[@"photo"];
        NSURL *url = [NSURL URLWithString:photo];
        if (url != nil) {
            UIImage *image = [UIImage imageNamed:@"default_user"];
            //先用默认头像去占位，根据url去判断是否缓存，如果没有就去下载
            [_headImageView sd_setImageWithURL:url placeholderImage:image];
        }else{
            [self defaultSetting];
        }
    }else {
        [self defaultSetting];
    }
    [self.tableView reloadData];
}

-(void)failureWithTask:(NSURLSessionDataTask *)task error:(NSError *)error{
   // [self defaultSetting];
    [self.tableView reloadData];
}

-(void)defaultSetting {
    _headImageView.image = [UIImage imageNamed:@"default_user"];
    _nicknameLabel.text = @"昵称未知";
}

-(void)pushWithStoryboardID : (NSString *)identfier data:(NSObject *)data{
    //导航效果
    UINavigationController *nav = self.parentViewController.childViewControllers[1];
    [nav pushViewControllerWithStoryboardID:identfier animated:NO data:data];
    
    //
    [self.slideMenuController switchController];
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return [super numberOfSectionsInTableView:tableView];
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return (_logged ? 3:0);
//}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = indexPath.row;
    if (index == 0) { // 个人资料
        NSString *objectId = [[User currentUser] objectId];
        NSDictionary *data = @{@"isMe":@YES,@"objectId":objectId};
        [self pushWithStoryboardID:@"Personal" data:data];
    }
    else if (index == 1){
        //消息中心
    }
    else{
        //注销
        [User loginout];
        
        _logged = NO;
        [self refresh];
        //
        [self.tableView reloadData];
    }
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
