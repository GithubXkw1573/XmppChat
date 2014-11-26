//
//  XCSubcribeController.m
//  XmppChatDemo
//
//  Created by 许开伟 on 14-10-24.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "XCSubcribeController.h"

@interface XCSubcribeController ()

@end

@implementation XCSubcribeController
@synthesize userField,subcribleRecord;


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"添加好友";
    [self appDelegate].delegate = self;
    self.subcribleRecord = [[NSMutableArray alloc] initWithCapacity:1];
    [self initComponent];
    
    tView =[[UITableView alloc] initWithFrame:CGRectMake(0, 50+44+30, 320, 548-44-44) style:UITableViewStylePlain];
    tView.delegate =self;
    tView.dataSource =self;
    tView.backgroundColor=[UIColor clearColor];
    tView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (XCAppDelegate *)appDelegate {
	return (XCAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (XMPPStream *)xmppStream {
	return [[self appDelegate] xmppStream];
}

-(void) initComponent
{
    UITextField *usernameField = [[UITextField alloc] initWithFrame:CGRectMake(10, 40+44, 200, 27)];
    usernameField.placeholder = @"用户名";
    usernameField.borderStyle = UITextBorderStyleRoundedRect;
    self.userField = usernameField;
    [self.view addSubview:usernameField];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(230, 40+44, 80, 27)];
    [btn setTitle:@"搜索" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btn.layer.masksToBounds = YES;
    btn.layer.borderWidth = 1.0f;
    btn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    btn.layer.cornerRadius = 4;
    [btn addTarget:self action:@selector(searchUser:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)searchUser:(UIButton*)btn
{
    NSString *userkey = self.userField.text;
    if (userkey.length > 0) {
        //发送订阅
        XMPPPresence *subpresence = [XMPPPresence presenceWithType:@"subscribe" to:[XMPPJID jidWithUser:userkey domain:kDomain resource:@"/"]];
        [[self xmppStream] sendElement:subpresence];
        [userField resignFirstResponder];
    }
}

-(void)newSubscrible:(NSString *)fromUser Type:(NSString *)type
{
    if ([type isEqualToString:@"subscribed"]) {
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
        
        [dictionary setObject:fromUser forKey:@"fromUser"];
        [dictionary setObject:@"已同意" forKey:@"type"];
        [self.subcribleRecord addObject:dictionary];
    }else if ([type isEqualToString:@"unsubscribed"]){
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
        
        [dictionary setObject:fromUser forKey:@"fromUser"];
        [dictionary setObject:@"待同意" forKey:@"type"];
        [self.subcribleRecord addObject:dictionary];
    }
    [tView reloadData];
}


#pragma mark -
#pragma mark Table view delegates

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSDictionary *s = (NSDictionary *) [subcribleRecord objectAtIndex:indexPath.row];
	
	static NSString *CellIdentifier = @"UserCellIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
	
	cell.textLabel.text = [s objectForKey:@"fromUser"];
    if ([[s objectForKey:@"type"] isEqualToString:@"已同意"]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
	return cell;
	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return [subcribleRecord count];
	
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	
	return 1;
	
}

@end
