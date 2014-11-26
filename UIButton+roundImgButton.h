//
//  UIButton+roundImgButton.h
//  MPMoviePlayer
//
//  Created by 许开伟 on 14-9-22.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (roundImgButton)
+(UIButton*)initWithImgButton:(NSString *)imgString withRect:(CGRect)rect SEL:(SEL)selector  Responsder:(id)object Tag:(NSInteger)tag;

+(UIButton*)initWithRoundImgButton:(NSString *)imgString withRect:(CGRect)rect SEL:(SEL)selector  Responsder:(id)object Tag:(NSInteger)tag;

+(UIButton*)initWithTextButton:(NSString *)title TitleColor:(UIColor*)titleColor withFont:(UIFont*)font withRect:(CGRect)rect SEL:(SEL)selector  Responsder:(id)object Tag:(NSInteger)tag;

+(UIButton*)initWithTextBorderButton:(NSString *)title TitleColor:(UIColor*)titleColor withFont:(UIFont*)font borderColor:(UIColor*)borderColor cornerRadius:(CGFloat)cornerRadius withRect:(CGRect)rect SEL:(SEL)selector  Responsder:(id)object Tag:(NSInteger)tag;

+(UIButton*)initWithImgTextButton:(NSString *)title TitleColor:(UIColor*)titleColor withFont:(UIFont*)font withImg:(NSString*)imgString withRect:(CGRect)rect SEL:(SEL)selector  Responsder:(id)object Tag:(NSInteger)tag;

+(UIButton*)initWithCustomImgTextButton:(NSString *)title TitleColor:(UIColor*)titleColor withFont:(UIFont*)font titleInsets:(UIEdgeInsets)insets withImg:(NSString*)imgString withRect:(CGRect)rect SEL:(SEL)selector  Responsder:(id)object Tag:(NSInteger)tag;

@end
