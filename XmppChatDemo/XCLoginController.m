//
//  XCLoginController.m
//  XmppChatDemo
//
//  Created by 许开伟 on 14-10-22.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "XCLoginController.h"

@interface XCLoginController ()

@end

@implementation XCLoginController
@synthesize userIdField;
@synthesize passwordField;
@synthesize serverField;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Xmpp Demo";
    [self initComponents];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    //更改源码测试
    
}


-(void)initComponents
{
    UILabel *usernameLabel = [UILabel initWithText:@"用户名：" withTextColor:[UIColor grayColor] withFont:[UIFont systemFontOfSize:16] withRect:CGRectMake(10, 50+44, 80, 27) withTag:0];
    UILabel *passwordLabel = [UILabel initWithText:@"密  码：" withTextColor:[UIColor grayColor] withFont:[UIFont systemFontOfSize:16] withRect:CGRectMake(10, 100+44, 80, 27) withTag:0];
    UILabel *serverLabel = [UILabel initWithText:@"服务器：" withTextColor:[UIColor grayColor] withFont:[UIFont systemFontOfSize:16] withRect:CGRectMake(10, 150+44, 80, 27) withTag:0];
    [self.view addSubview:usernameLabel];
    [self.view addSubview:passwordLabel];
    [self.view addSubview:serverLabel];
    
    userIdField = [[UITextField alloc] initWithFrame:CGRectMake(100, 50+44, 200, 27)];
    userIdField.placeholder = @"openfire注册的用户名";
    [self.view addSubview:userIdField];
    
    passwordField = [[UITextField alloc] initWithFrame:CGRectMake(100, 100+44, 200, 27)];
    passwordField.placeholder = @"openfire注册的密码";
    [self.view addSubview:passwordField];
    
    serverField = [[UITextField alloc] initWithFrame:CGRectMake(100, 150+44, 200, 27)];
    serverField.placeholder = @"服务器地址";
    [self.view addSubview:serverField];
    
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 200+44, 300, 30)];
    [loginBtn setTitle:@"登  录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"lastLoginInfo"]) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *userId = [defaults stringForKey:@"userid"];
        NSString *pass = [defaults stringForKey:@"password"];
        NSString *server = [defaults stringForKey:@"server"];
        userIdField.text = userId;
        passwordField.text = pass;
        serverField.text = server;
    }
}

-(void)login:(UIButton*)btn
{
    //登录
    [[NSUserDefaults standardUserDefaults] setObject:userIdField.text forKey:@"userid"];
    [[NSUserDefaults standardUserDefaults] setObject:passwordField.text forKey:@"password"];
    [[NSUserDefaults standardUserDefaults] setObject:serverField.text forKey:@"server"];
    [[NSUserDefaults standardUserDefaults] synchronize];//保存
    XCFriendListController *friendList = [[XCFriendListController alloc] init];
    [self.navigationController pushViewController:friendList animated:YES];
    //[self dismissViewControllerAnimated:YES completion:nil];
}

@end
