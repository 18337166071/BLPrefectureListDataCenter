//
//  UIButton+BLImage.h
//  BLImage
//
//  Created by casa on 2017/7/27.
//  Copyright © 2017年 casa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (BLImage)
- (void)bl_setBackgroundImageWithURL:(NSURL *)imageUrl forState:(UIControlState)state;
- (void)bl_setBackgroundImageWithURL:(NSURL *)imageUrl forState:(UIControlState)state placeholderImage:(UIImage *)placeholderImage;

- (void)bl_setImageWithURL:(NSURL *)imageUrl forState:(UIControlState)state;
- (void)bl_setImageWithURL:(NSURL *)imageUrl forState:(UIControlState)state placeholderImage:(UIImage *)placeholderImage;

- (void)bl_setImageWithURL:(NSURL *)imageUrl forState:(UIControlState)state animated:(BOOL)animated;
- (void)bl_setImageWithURL:(NSURL *)imageUrl forState:(UIControlState)state animated:(BOOL)animated animationDuration:(CGFloat)animationDuration;
- (void)bl_setImageWithURL:(NSURL *)imageUrl forState:(UIControlState)state placeholderImage:(UIImage *)placeholderImage animated:(BOOL)animated animationDuration:(CGFloat)animationDuration completed:(void (^)(UIImage *image, NSError *error, NSURL *imageURL))completed;
@end
