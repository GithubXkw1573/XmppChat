//
//  UIButton+roundImgButton.m
//  MPMoviePlayer
//
//  Created by 许开伟 on 14-9-22.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "UIButton+roundImgButton.h"

@implementation UIButton (roundImgButton)

//创建图片（不含文字）的可点击按钮
+(UIButton*)initWithImgButton:(NSString *)imgString withRect:(CGRect)rect SEL:(SEL)selector  Responsder:(id)object Tag:(NSInteger)tag
{
    UIButton *btn = [[UIButton alloc] initWithFrame:rect];
    btn.backgroundColor = [UIColor clearColor];
    [btn setImage:[UIImage imageNamed:imgString] forState:UIControlStateNormal];
    btn.tag = tag;
    if (selector!=nil) {
        [btn addTarget:object action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    
    return btn;
}

//创建圆形图片（不含文字）的可点击按钮
+(UIButton*)initWithRoundImgButton:(NSString *)imgString withRect:(CGRect)rect SEL:(SEL)selector  Responsder:(id)object Tag:(NSInteger)tag
{
    UIButton *btn = [[UIButton alloc] initWithFrame:rect];
    btn.backgroundColor = [UIColor clearColor];
    [btn setImage:[UIImage imageNamed:imgString] forState:UIControlStateNormal];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = rect.size.width/2.0f;
    btn.tag = tag;
    if (selector!=nil) {
        [btn addTarget:object action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    
    return btn;
}

//创建纯文字的可点击按钮
+(UIButton*)initWithTextButton:(NSString *)title TitleColor:(UIColor*)titleColor withFont:(UIFont*)font withRect:(CGRect)rect SEL:(SEL)selector  Responsder:(id)object Tag:(NSInteger)tag
{
    UIButton *btn = [[UIButton alloc] initWithFrame:rect];
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.tag = tag;
    if (selector!=nil) {
        [btn addTarget:object action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    
    return btn;
}

//创建纯文字带边框的可点击按钮(边框大小默认为1)
+(UIButton*)initWithTextBorderButton:(NSString *)title TitleColor:(UIColor*)titleColor withFont:(UIFont*)font borderColor:(UIColor*)borderColor cornerRadius:(CGFloat)cornerRadius withRect:(CGRect)rect SEL:(SEL)selector  Responsder:(id)object Tag:(NSInteger)tag
{
    UIButton *btn = [[UIButton alloc] initWithFrame:rect];
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.layer.masksToBounds = YES;
    btn.layer.borderWidth = 1.0f;
    btn.layer.borderColor = [borderColor CGColor];
    btn.layer.cornerRadius = cornerRadius;
    btn.tag = tag;
    if (selector!=nil) {
        [btn addTarget:object action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    
    return btn;
}

//创建图片带文字的可点击按钮
+(UIButton*)initWithImgTextButton:(NSString *)title TitleColor:(UIColor*)titleColor withFont:(UIFont*)font withImg:(NSString*)imgString withRect:(CGRect)rect SEL:(SEL)selector  Responsder:(id)object Tag:(NSInteger)tag
{
    UIButton *btn = [[UIButton alloc] initWithFrame:rect];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundImage:[UIImage imageNamed:imgString] forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.tag = tag;
    if (selector!=nil) {
        [btn addTarget:object action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    
    return btn;
}

//创建自定义文字位置的带图片的可点击按钮
+(UIButton*)initWithCustomImgTextButton:(NSString *)title TitleColor:(UIColor*)titleColor withFont:(UIFont*)font titleInsets:(UIEdgeInsets)insets withImg:(NSString*)imgString withRect:(CGRect)rect SEL:(SEL)selector  Responsder:(id)object Tag:(NSInteger)tag
{
    UIButton *btn = [[UIButton alloc] initWithFrame:rect];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundImage:[UIImage imageNamed:imgString] forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
    [btn setContentEdgeInsets:insets];
    btn.tag = tag;
    if (selector!=nil) {
        [btn addTarget:object action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    
    return btn;
}

@end
