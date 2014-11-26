//
//  XCFriendListController.m
//  XmppChatDemo
//
//  Created by 许开伟 on 14-10-22.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "XCFriendListController.h"

@interface XCFriendListController ()

@end

@implementation XCFriendListController
@synthesize onlineBuddies;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Friend List";
    tView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 548-44-44) style:UITableViewStylePlain];
    tView.delegate =self;
    tView.dataSource =self;
    tView.backgroundColor=[UIColor clearColor];
    tView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tView];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"添加好友" style:UIBarButtonItemStyleBordered target:self action:@selector(addSubcribe)];
    self.navigationItem.rightBarButtonItem = right;
    
    self.onlineBuddies = [[NSMutableArray alloc] initWithCapacity:1];
    [self appDelegate].delegate = self;
    
    NSString *login = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
	
	if (login) {
		
		if ([[self appDelegate] connect]) {
			
			NSLog(@"show buddy list");
			//[[self appDelegate] queryRoster];
		}
		
	} else {
		
		[self showLogin];
		
	}
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

- (void) showLogin {
	
	XCLoginController *loginController = [[XCLoginController alloc] init];
	[self presentViewController:loginController animated:YES completion:nil];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
	
	
}

#pragma mark -
#pragma mark Table view delegates

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSString *s = (NSString *) [onlineBuddies objectAtIndex:indexPath.row];
	
	static NSString *CellIdentifier = @"UserCellIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
	
	cell.textLabel.text = s;
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	return cell;
	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return [onlineBuddies count];
	
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	
	return 1;
	
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tView deselectRowAtIndexPath:indexPath animated:YES];
    XCChatController *chat = [[XCChatController alloc] init];
    chat.chatter = [NSString stringWithFormat:@"%@",[self.onlineBuddies objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:chat animated:YES];
}


-(void)addSubcribe
{
    //进入添加订阅界面
    XCSubcribeController *sub = [[XCSubcribeController alloc] init];
    [self.navigationController pushViewController:sub animated:YES];
}



#pragma mark - MyXMPP delegate
- (void)newBuddyOnline:(NSString *)buddyName {
    [self.onlineBuddies addObject:buddyName];
    [tView reloadData];
}

- (void)buddyWentOffline:(NSString *)buddyName {
    [self.onlineBuddies removeObject:buddyName];
    [tView reloadData];
}

@end
