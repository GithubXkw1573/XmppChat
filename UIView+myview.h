//
//  UIView+myview.h
//  MPMoviePlayer
//
//  Created by 许开伟 on 14-9-23.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (myview)
+(UIView*)initViewWithRect:(CGRect)rect withBackColor:(UIColor*)bgColor withTag:(NSInteger)tag;
+(UIView*)initViewWithRect:(CGRect)rect withBackColor:(UIColor*)bgColor withTag:(NSInteger)tag withSEL:(SEL)selector withResponder:(id)object;
@end
