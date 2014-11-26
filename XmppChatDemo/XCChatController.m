//
//  XCChatController.m
//  XmppChatDemo
//
//  Created by 许开伟 on 14-10-24.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//
#define padding 20

#import "XCChatController.h"

@interface XCChatController ()

@end

@implementation XCChatController
@synthesize chatRecord;

- (XCAppDelegate *)appDelegate {
	return (XCAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (XMPPStream *)xmppStream {
	return [[self appDelegate] xmppStream];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=self.chatter;
    [self appDelegate].delegate = self;
    [self initComponent];
    chatRecord = [[NSMutableArray alloc] init];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:[NSString  stringWithFormat:@"%@message",self.chatter]]) {
        NSMutableArray *offlineData = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString  stringWithFormat:@"%@message",self.chatter]];
        chatRecord = offlineData;
    }
    
    tView =[[UITableView alloc] initWithFrame:CGRectMake(0, 44+25, 320, applicationHeight-44-44-25) style:UITableViewStylePlain];
    tView.delegate =self;
    tView.dataSource =self;
    tView.backgroundColor=[UIColor clearColor];
    tView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tView];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, applicationHeight-44,320, 0.5)];
    imageview.image = [UIImage imageNamed:@"线"];
    [self.view addSubview:imageview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void) initComponent
{
    UITextField *inputField = [[UITextField alloc] initWithFrame:CGRectMake(10, applicationHeight-44+17, 220, 30)];
    inputField.borderStyle = UITextBorderStyleRoundedRect;
    inputField.returnKeyType = UIReturnKeySend;
    inputField.delegate = self;
    sendTextField = inputField;
    [self.view addSubview:inputField];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(250, applicationHeight-44+17, 60, 30)];
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btn.layer.masksToBounds = YES;
    btn.layer.borderWidth = 1.0f;
    btn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    btn.layer.cornerRadius = 4;
    [btn addTarget:self action:@selector(sendMsg) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)sendMsg
{
    //本地输入框中的信息
    NSString *message = sendTextField.text;
    
    if (message.length > 0) {
        
        //XMPPFramework主要是通过KissXML来生成XML文件
        //生成<body>文档
        NSXMLElement *body = [NSXMLElement elementWithName:@"body"];
        [body setStringValue:message];
        
        //生成XML消息文档
        NSXMLElement *mes = [NSXMLElement elementWithName:@"message"];
        //消息类型
        [mes addAttributeWithName:@"type" stringValue:@"chat"];
        //发送给谁
        [mes addAttributeWithName:@"to" stringValue:[NSString stringWithFormat:@"%@@%@",self.chatter,kDomain]];
        //由谁发送
        [mes addAttributeWithName:@"from" stringValue:[NSString stringWithFormat:@"%@@%@",[[NSUserDefaults standardUserDefaults] stringForKey:@"userid"],kDomain]];
        //组合
        [mes addChild:body];
        
        //发送消息
        [[self xmppStream] sendElement:mes];
        
        sendTextField.text = @"";
        [sendTextField resignFirstResponder];
        
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
        
        [dictionary setObject:@"我" forKey:@"fromUser"];
        [dictionary setObject:message forKey:@"content"];
        
        [self.chatRecord addObject:dictionary];
        
        //重新刷新tableView
        [tView reloadData];
        
    }
}

#pragma mark -
#pragma mark Table view delegates

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSDictionary *s = (NSDictionary *) [chatRecord objectAtIndex:indexPath.row];
	NSString *message = [s objectForKey:@"content"];
    NSString *sender = [s objectForKey:@"fromUser"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm"];
    NSString *time = [formatter stringFromDate:[NSDate date]];
    
	static NSString *CellIdentifier = @"UserCellIdentifier";
	
	XCMessageCell *cell = (XCMessageCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[XCMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
	CGSize textSize = {260.0 ,10000.0};
    CGSize size = [message sizeWithFont:[UIFont boldSystemFontOfSize:14] constrainedToSize:textSize lineBreakMode:UILineBreakModeWordWrap];
    
    size.width +=(padding/2);
    
    cell.messageContentView.text = message;
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.userInteractionEnabled = NO;
    
    UIImage *bgImage = nil;
    
    //发送消息
    if ([sender isEqualToString:@"我"]) {
        //背景图
        bgImage = [[UIImage imageNamed:@"BlueBubble2.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:15];
        [cell.messageContentView setFrame:CGRectMake(padding+5, padding*2-10, size.width, size.height+10)];
        
        [cell.bgImageView setFrame:CGRectMake(cell.messageContentView.frame.origin.x - padding/2, cell.messageContentView.frame.origin.y - padding/2+5, size.width + padding, size.height + padding-5)];
    }else {
        
        bgImage = [[UIImage imageNamed:@"GreenBubble2.png"] stretchableImageWithLeftCapWidth:14 topCapHeight:15];
        
        [cell.messageContentView setFrame:CGRectMake(320-size.width - padding, padding*2-10, size.width, size.height+10)];
        [cell.bgImageView setFrame:CGRectMake(cell.messageContentView.frame.origin.x - padding/2, cell.messageContentView.frame.origin.y - padding/2+5, size.width + padding, size.height + padding-5)];
    }
    
    cell.bgImageView.image = bgImage;
    cell.senderAndTimeLabel.text = [NSString stringWithFormat:@"%@ %@", sender, time];
    
	return cell;
	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return [chatRecord count];
	
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	
	return 1;
	
}

//每一行的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableDictionary *dict  = [chatRecord objectAtIndex:indexPath.row];
    NSString *msg = [dict objectForKey:@"content"];
    
    CGSize textSize = {260.0 , 10000.0};
    CGSize size = [msg sizeWithFont:[UIFont boldSystemFontOfSize:14] constrainedToSize:textSize lineBreakMode:UILineBreakModeWordWrap];
    
    size.height += padding*2;
    
    CGFloat height = size.height < 65 ? 65 : size.height;
    
    return height;
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self sendMsg];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(self.chatRecord.count-1) inSection:0];
    [tView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    return true;
}

-(void)newMessageReceived:(NSDictionary *)dict
{
    [self.chatRecord addObject:dict];
    
    //重新刷新tableView
    [tView reloadData];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(self.chatRecord.count-1) inSection:0];
    [tView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.3f animations:^{
        CGRect myframe = self.view.frame;
        self.view.frame = CGRectMake(myframe.origin.x, myframe.origin.y-240, myframe.size.width, myframe.size.height);
        
    }];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.3f animations:^{
        CGRect myframe = self.view.frame;
        self.view.frame = CGRectMake(myframe.origin.x, myframe.origin.y+240, myframe.size.width, myframe.size.height);
        
    }];
}

@end
