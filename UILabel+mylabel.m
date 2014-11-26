//
//  UILabel+mylabel.m
//  MPMoviePlayer
//
//  Created by 许开伟 on 14-9-23.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "UILabel+mylabel.h"

@implementation UILabel (mylabel)

+(UILabel*)initWithText:(NSString *)text withTextColor:(UIColor*)textColor withFont:(UIFont*)font withRect:(CGRect)rect withTag:(NSInteger)tag
{
    UILabel *mylbl = [[UILabel alloc] initWithFrame:rect];
    mylbl.text = text;
    mylbl.textAlignment = NSTextAlignmentLeft;
    mylbl.textColor = textColor;
    mylbl.tag = tag;
    mylbl.font = font;
    mylbl.backgroundColor = [UIColor clearColor];
    return mylbl;
}

//创建一个自动根据文字长度调整label宽度
+(UILabel*)initFitSizeLabelWithText:(NSString *)text withTextColor:(UIColor*)textColor withFont:(UIFont*)font withRect:(CGRect)rect withTag:(NSInteger)tag
{
    UILabel *mylbl = [[UILabel alloc] initWithFrame:rect];
    mylbl.text = text;
    mylbl.textAlignment = NSTextAlignmentLeft;
    mylbl.textColor = textColor;
    mylbl.tag = tag;
    mylbl.font = font;
    mylbl.backgroundColor = [UIColor clearColor];
    CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(rect.size.width, rect.size.height) lineBreakMode:NSLineBreakByWordWrapping];
    mylbl.frame = CGRectMake(rect.origin.x, rect.origin.y, size.width, rect.size.height);
    return mylbl;
}

@end
