//
//  XCChatController.h
//  XmppChatDemo
//
//  Created by 许开伟 on 14-10-24.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCAppDelegate.h"
#import "XCMessageCell.h"

@interface XCChatController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,MyXMPPDelegate>
{
    UITableView *tView;
    UITextField *sendTextField;
    NSMutableArray *chatRecord;
}

@property (nonatomic,retain) NSString *chatter;
@property (nonatomic,retain) NSMutableArray *chatRecord;

@end
