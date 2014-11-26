//
//  UILabel+mylabel.h
//  MPMoviePlayer
//
//  Created by 许开伟 on 14-9-23.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (mylabel)
+(UILabel*)initWithText:(NSString *)text withTextColor:(UIColor*)textColor withFont:(UIFont*)font withRect:(CGRect)rect withTag:(NSInteger)tag;
+(UILabel*)initFitSizeLabelWithText:(NSString *)text withTextColor:(UIColor*)textColor withFont:(UIFont*)font withRect:(CGRect)rect withTag:(NSInteger)tag;

@end
