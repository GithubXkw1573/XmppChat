//
//  XCFriendListController.h
//  XmppChatDemo
//
//  Created by 许开伟 on 14-10-22.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCAppDelegate.h"
#import "XCLoginController.h"
#import "XCSubcribeController.h"
#import "XCChatController.h"

@interface XCFriendListController : UIViewController<UITableViewDataSource,UITableViewDelegate,MyXMPPDelegate>{
	
	UITableView *tView;
	NSMutableArray *onlineBuddies;
}

@property (nonatomic,retain) NSMutableArray *onlineBuddies;

@end
