//
//  UIImageView+roundImgView.m
//  MPMoviePlayer
//
//  Created by 许开伟 on 14-9-23.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import "UIImageView+roundImgView.h"

@implementation UIImageView (roundImgView)
//创建普通uiimageview
+(UIImageView*)initWithRect:(CGRect)rect withImgString:(NSString*)imgString withTag:(NSInteger)tag
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:rect];
    imgView.backgroundColor = [UIColor clearColor];
    imgView.image = [UIImage imageNamed:imgString];
    imgView.tag = tag;
    return imgView;
}

//创建可点击的uiimageview
+(UIImageView*)initTapViewWithRect:(CGRect)rect withImgString:(NSString*)imgString withTag:(NSInteger)tag withSEL:(SEL)selector withResponder:(id)object
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:rect];
    imgView.backgroundColor = [UIColor clearColor];
    imgView.image = [UIImage imageNamed:imgString];
    imgView.tag = tag;
    imgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:object action:selector];
    [imgView addGestureRecognizer:tap];
    return imgView;
}

//创建圆形区域的uiimageview
+(UIImageView*)initRoundViewWithRect:(CGRect)rect withImgString:(NSString*)imgString withTag:(NSInteger)tag
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:rect];
    imgView.backgroundColor = [UIColor clearColor];
    imgView.image = [UIImage imageNamed:imgString];
    imgView.tag = tag;
    imgView.layer.masksToBounds = YES;
    imgView.layer.cornerRadius = imgView.frame.size.width/2.0f;
    return imgView;
}

//创建圆形区域可点击的uiimageview
+(UIImageView*)initRoundTapViewWithRect:(CGRect)rect withImgString:(NSString*)imgString withTag:(NSInteger)tag withSEL:(SEL)selector withResponder:(id)object
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:rect];
    imgView.backgroundColor = [UIColor clearColor];
    imgView.image = [UIImage imageNamed:imgString];
    imgView.tag = tag;
    imgView.layer.masksToBounds = YES;
    imgView.layer.cornerRadius = imgView.frame.size.width/2.0f;
    imgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:object action:selector];
    [imgView addGestureRecognizer:tap];
    return imgView;
}



//***************************************下面四种重载是针对网络加载URL图片链接形式的*****************************************//

+(UIImageView*)initWithImgUrlString:(NSString*)urlString withRect:(CGRect)rect withTag:(NSInteger)tag
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:rect];
    imgView.backgroundColor = [UIColor clearColor];
    imgView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]];
    imgView.tag = tag;
    return imgView;
}

+(UIImageView*)initTapViewWithImgUrlString:(NSString*)urlString withRect:(CGRect)rect withTag:(NSInteger)tag withSEL:(SEL)selector withResponder:(id)object
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:rect];
    imgView.backgroundColor = [UIColor clearColor];
    imgView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]];
    imgView.tag = tag;
    imgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:object action:selector];
    [imgView addGestureRecognizer:tap];
    return imgView;
}

+(UIImageView*)initRoundViewWithImgUrlString:(NSString*)urlString withRect:(CGRect)rect withTag:(NSInteger)tag
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:rect];
    imgView.backgroundColor = [UIColor clearColor];
    imgView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]];
    imgView.tag = tag;
    imgView.layer.masksToBounds = YES;
    imgView.layer.cornerRadius = imgView.frame.size.width/2.0f;
    return imgView;
}

+(UIImageView*)initRoundTapViewWithImgUrlString:(NSString*)urlString withRect:(CGRect)rect withTag:(NSInteger)tag withSEL:(SEL)selector withResponder:(id)object
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:rect];
    imgView.backgroundColor = [UIColor clearColor];
    imgView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]];
    imgView.tag = tag;
    imgView.layer.masksToBounds = YES;
    imgView.layer.cornerRadius = imgView.frame.size.width/2.0f;
    imgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:object action:selector];
    [imgView addGestureRecognizer:tap];
    return imgView;
}

@end
