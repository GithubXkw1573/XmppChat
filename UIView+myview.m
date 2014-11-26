//
//  UIView+myview.m
//  MPMoviePlayer
//
//  Created by 许开伟 on 14-9-23.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "UIView+myview.h"

@implementation UIView (myview)

+(UIView*)initViewWithRect:(CGRect)rect withBackColor:(UIColor*)bgColor withTag:(NSInteger)tag
{
    UIView *myview = [[UIView alloc] initWithFrame:rect];
    myview.backgroundColor = bgColor;
    myview.tag = tag;
    return myview;
}

//创建可点击的uiview
+(UIView*)initViewWithRect:(CGRect)rect withBackColor:(UIColor*)bgColor withTag:(NSInteger)tag withSEL:(SEL)selector withResponder:(id)object
{
    UIView *myview = [[UIView alloc] initWithFrame:rect];
    myview.backgroundColor = bgColor;
    myview.tag = tag;
    myview.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:object action:selector];
    [myview addGestureRecognizer:tap];
    return myview;
}
@end
