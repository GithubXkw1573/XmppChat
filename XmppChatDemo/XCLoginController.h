//
//  XCLoginController.h
//  XmppChatDemo
//
//  Created by 许开伟 on 14-10-22.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+mylabel.h"
#import "UIButton+roundImgButton.h"
#import "XMPP.h"
#import "XCFriendListController.h"

@interface XCLoginController : UIViewController
@property (nonatomic,retain) UITextField *userIdField;
@property (nonatomic,retain) UITextField *passwordField;
@property (nonatomic,retain) UITextField *serverField;
@end
