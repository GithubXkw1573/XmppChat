//
//  UIImageView+roundImgView.h
//  MPMoviePlayer
//
//  Created by 许开伟 on 14-9-23.
//  Copyright (c) 2014年 许开伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (roundImgView)
+(UIImageView*)initWithRect:(CGRect)rect withImgString:(NSString*)imgString withTag:(NSInteger)tag;
+(UIImageView*)initTapViewWithRect:(CGRect)rect withImgString:(NSString*)imgString withTag:(NSInteger)tag withSEL:(SEL)selector withResponder:(id)object;
+(UIImageView*)initRoundViewWithRect:(CGRect)rect withImgString:(NSString*)imgString withTag:(NSInteger)tag;
+(UIImageView*)initRoundTapViewWithRect:(CGRect)rect withImgString:(NSString*)imgString withTag:(NSInteger)tag withSEL:(SEL)selector withResponder:(id)object;
+(UIImageView*)initWithImgUrlString:(NSString*)urlString withRect:(CGRect)rect withTag:(NSInteger)tag;
+(UIImageView*)initTapViewWithImgUrlString:(NSString*)urlString withRect:(CGRect)rect withTag:(NSInteger)tag withSEL:(SEL)selector withResponder:(id)object;
+(UIImageView*)initRoundViewWithImgUrlString:(NSString*)urlString withRect:(CGRect)rect withTag:(NSInteger)tag;
+(UIImageView*)initRoundTapViewWithImgUrlString:(NSString*)urlString withRect:(CGRect)rect withTag:(NSInteger)tag withSEL:(SEL)selector withResponder:(id)object;

@end
