//
//  XCMessageCell.h
//  XmppChatDemo
//
//  Created by 许开伟 on 14-10-27.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCMessageCell : UITableViewCell
@property(nonatomic, retain) UILabel *senderAndTimeLabel;
@property(nonatomic, retain) UITextView *messageContentView;
@property(nonatomic, retain) UIImageView *bgImageView;
@end
