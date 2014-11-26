//
//  XCAppDelegate.h
//  XmppChatDemo
//
//  Created by 许开伟 on 14-10-22.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

@protocol MyXMPPDelegate <NSObject>

@optional
//上线
- (void)newBuddyOnline:(NSString *)buddyName;
- (void)buddyWentOffline:(NSString *)buddyName;
- (void)didDisconnect;
//消息
- (void)newMessageReceived:(NSDictionary *)dict;
- (void)newSubscrible:(NSString*)fromUser Type:(NSString*)type;
@end


#import <UIKit/UIKit.h>
#import "XMPP.h"
#import "XCLoginController.h"


@class XCChatController;
@interface XCAppDelegate : UIResponder <UIApplicationDelegate,XMPPStreamDelegate,UIAlertViewDelegate>
{
    XMPPStream *xmppStream;
    NSString *password;
    BOOL isOpen;//xmppStream是否开着
    NSMutableArray *allFriends;
    NSString *currMessageId;
    NSString *currFromUser;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationContoller;
@property (nonatomic,readonly) XMPPStream *xmppStream;
@property (nonatomic,retain) NSMutableArray *allFriends;
@property (nonatomic , assign) id<MyXMPPDelegate> delegate;
-(BOOL)connect;
-(void)disconnect;
-(void)setupStream;
-(void)goOnline;
-(void)goOffline;
- (void)queryRoster;
@end
