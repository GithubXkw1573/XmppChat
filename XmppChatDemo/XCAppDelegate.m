//
//  XCAppDelegate.m
//  XmppChatDemo
//
//  Created by 许开伟 on 14-10-22.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "XCAppDelegate.h"

@implementation XCAppDelegate
@synthesize xmppStream,allFriends;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    XCLoginController *loginCtrl = [[XCLoginController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginCtrl];
    self.navigationContoller = nav;
    self.window.rootViewController = nav;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


-(void)setupStream{
    
    //初始化XMPPStream
    xmppStream = [[XMPPStream alloc] init];
#if !TARGET_IPHONE_SIMULATOR
    {
        // 想要xampp在后台也能运行?
        //
        // P.S. - 虚拟机不支持后台
        
        xmppStream.enableBackgroundingOnSocket = YES;
    }
#endif
    [xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
}

-(void)goOnline{
    
    //发送在线状态
    XMPPPresence *presence = [XMPPPresence presence];
    [[self xmppStream] sendElement:presence];
    
    
}

-(void)goOffline{
    
    //发送下线状态
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"unavailable"];
    [[self xmppStream] sendElement:presence];
    
}

-(BOOL)connect{
    
    [self setupStream];
    
    //从本地取得用户名，密码和服务器地址
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *userId = [defaults stringForKey:@"userid"];
    NSString *pass = [defaults stringForKey:@"password"];
    NSString *server = [defaults stringForKey:@"server"];
    
    if (![xmppStream isDisconnected]) {
        return YES;
    }
    
    if (userId == nil || pass == nil) {
        return NO;
    }
    
    //设置用户
    XMPPJID *myjid = [XMPPJID jidWithUser:userId domain:server resource:@"/"  ];
    [self.xmppStream setMyJID:myjid];
//    [xmppStream setMyJID:[XMPPJID jidWithString:userId]];
    //设置服务器
    [xmppStream setHostName:server];
    //密码
    password = pass;
    
    //连接服务器
    NSError *error = nil;
    if (![self.xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&error])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:[NSString stringWithFormat:@"Can't connect to server %@", [error localizedDescription]]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
        
        return NO;
    }
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"lastLoginInfo"];
    return YES;
}

-(void)disconnect{
    
    [self goOffline];
    [xmppStream disconnect];
}

#pragma mark -
#pragma mark XMPP delegates

- (void)xmppStreamDidConnect:(XMPPStream *)sender {
	
	isOpen = YES;
	NSError *error = nil;
    
	[[self xmppStream] authenticateWithPassword:password error:&error];
	
}

- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender {
	
	[self goOnline];
	
}

- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(NSXMLElement *)error
{
    NSLog(@"%@",[error description]);
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:[NSString stringWithFormat:@"didNotAuthenticate to server %@", [error description]]
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    [alertView show];
}

- (void)queryRoster {
    NSXMLElement *query = [NSXMLElement elementWithName:@"query" xmlns:@"jabber:iq:roster"];
    NSXMLElement *iq = [NSXMLElement elementWithName:@"iq"];
    XMPPJID *myJID = self.xmppStream.myJID;
    [iq addAttributeWithName:@"from" stringValue:myJID.description];
    [iq addAttributeWithName:@"to" stringValue:myJID.domain];
    [iq addAttributeWithName:@"id" stringValue:[self generateID]];
    [iq addAttributeWithName:@"type" stringValue:@"get"];
    [iq addChild:query];
    [self.xmppStream sendElement:iq];
}

-(NSString*)generateID
{
    NSDateFormatter *nsdf2=[[NSDateFormatter alloc] init];
    [nsdf2 setDateStyle:NSDateFormatterLongStyle];
    [nsdf2 setDateFormat:@"YYYYMMDDHHmmss"];
    NSString *date=[nsdf2 stringFromDate:[NSDate date]];
    currMessageId = date;
    return date;
}

- (BOOL)xmppStream:(XMPPStream *)sender didReceiveIQ:(XMPPIQ *)iq {
	if (!self.allFriends) {
        self.allFriends = [[NSMutableArray alloc] init];
    }else{
        [self.allFriends removeAllObjects];
    }
    
	NSString *str=@"";
    //    NSLog(@"获取到好友列表didReceiveIQ: %@",iq.description);
    if ([@"result" isEqualToString:iq.type]) {
        NSXMLElement *query = iq.childElement;
        if ([@"query" isEqualToString:query.name]) {
            NSArray *items = [query children];
            for (NSXMLElement *item in items) {
                NSString *jid = [item attributeStringValueForName:@"jid"];
                XMPPJID *xmppJID = [XMPPJID jidWithString:jid];
                NSLog(@"好友：%@",xmppJID);
                str = [NSString stringWithFormat:@"%@\n%@",str,xmppJID];
                [self.allFriends addObject:[NSString stringWithFormat:@"%@",xmppJID]];
            }
            //通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"user" object:nil userInfo:[NSDictionary dictionaryWithObject:self.allFriends forKey:@"userlist"]];
        }
    }
    
    return YES;
}

//收到消息
- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message{
    
    //    NSLog(@"message = %@", message);
    
    NSString *msg = [[message elementForName:@"body"] stringValue];
    NSString *from = [[message attributeForName:@"from"] stringValue];
    NSRange range = [from rangeOfString:@"@"];
    //去掉域名和资源名
    if (range.location != NSNotFound) {
        NSLog(@"%d,,,%d",range.length,range.location);
        from = [from substringToIndex:range.location];
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSString stringWithFormat:@"%@",msg] forKey:@"content"];
    [dict setObject:from forKey:@"fromUser"];
    
    if([self.navigationContoller.visibleViewController isKindOfClass:[XCChatController class]]){
        if (_delegate && [_delegate respondsToSelector:@selector(newMessageReceived:)]) {
            [_delegate newMessageReceived:dict];
        }
    }else{
        if ([[NSUserDefaults standardUserDefaults] objectForKey:[NSString  stringWithFormat:@"%@message",from]]) {
            NSMutableArray *oldArr = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString  stringWithFormat:@"%@message",from]];
            NSMutableArray *msgArr = [[NSMutableArray alloc] initWithArray:oldArr];
            [msgArr addObject:dict];
            [[NSUserDefaults standardUserDefaults]setObject:msgArr forKey:[NSString  stringWithFormat:@"%@message",from]];
        }else{
            NSMutableArray *msgArr = [[NSMutableArray alloc] init];
            [msgArr addObject:dict];
          [[NSUserDefaults standardUserDefaults]setObject:msgArr forKey:[NSString  stringWithFormat:@"%@message",from]];
        }
    }
    
    
}

//收到好友状态
- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence{
    
    //    NSLog(@"presence = %@", presence);
    
    //取得好友状态
    NSString *presenceType = [presence type]; //online/offline
    //当前用户
    NSString *userId = [[sender myJID] user];
    //在线用户
    NSString *presenceFromUser = [[presence from] user];
    
    if (![presenceFromUser isEqualToString:userId]) {
        
        //在线状态
        if ([presenceType isEqualToString:@"available"]) {
            
            //用户列表委托
            if (_delegate && [_delegate respondsToSelector:@selector(newBuddyOnline:)]) {
                [_delegate newBuddyOnline:[NSString stringWithFormat:@"%@", presenceFromUser]];
            }
        }else if ([presenceType isEqualToString:@"unavailable"]) {
            //用户列表委托
            if (_delegate && [_delegate respondsToSelector:@selector(buddyWentOffline:)]) {
                [_delegate buddyWentOffline:[NSString stringWithFormat:@"%@", presenceFromUser]];
            }
        }else if ([presenceType isEqualToString:@"subscribe"]){
            //询问是否同意订阅
            currFromUser = presenceFromUser;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                                message:[NSString stringWithFormat:@"是否同意来自：%@添加好友请求？", presenceFromUser]
                                                               delegate:self
                                                      cancelButtonTitle:@"是"
                                                      otherButtonTitles:@"否",nil];
            [alertView show];
            
        }else if ([presenceType isEqualToString:@"subscribed"]){
            //收到同意订阅的消息
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                                message:[NSString stringWithFormat:@"来自：%@同意你添加他为好友！", presenceFromUser]
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
            if (_delegate && [_delegate respondsToSelector:@selector(newSubscrible:Type:)]) {
                [_delegate newSubscrible:[NSString stringWithFormat:@"%@", presenceFromUser] Type:presenceType];
            }
        }
        
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        //发送同意订阅消息
        XMPPPresence *sendpresence = [XMPPPresence presenceWithType:@"subscribed" to:[XMPPJID jidWithUser:currFromUser domain:@"10.0.1.51" resource:@"/"]];
        [[self xmppStream] sendElement:sendpresence];
    }
}

@end
