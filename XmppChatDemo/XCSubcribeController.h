//
//  XCSubcribeController.h
//  XmppChatDemo
//
//  Created by 许开伟 on 14-10-24.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCAppDelegate.h"

@interface XCSubcribeController : UIViewController<MyXMPPDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tView;
    NSMutableArray *subcribleRecord;
}

@property (nonatomic,retain) UITextField *userField;
@property (nonatomic,retain) NSMutableArray *subcribleRecord;
@end
