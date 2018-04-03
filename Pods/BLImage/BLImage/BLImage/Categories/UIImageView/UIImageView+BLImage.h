//
//  UIImageView+BLImage.h
//  BLImage
//
//  Created by casa on 2017/7/27.
//  Copyright © 2017年 casa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYWebImage/UIImageView+YYWebImage.h>
#import <YYImage/YYImage.h>

@interface UIImageView (BLImage)

- (void)bl_setImageWithUrl:(NSURL *)imageUrl;
- (void)bl_setImageWithUrl:(NSURL *)imageUrl placeholderImage:(UIImage *)placeholderImage completed:(void (^)(UIImage *image, NSError *error, NSURL *imageURL))completed;
- (void)bl_setImageWithUrl:(NSURL *)imageUrl placeholderImage:(UIImage *)placeholderImage;
- (void)bl_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(YYWebImageOptions)options completed:(void (^)(UIImage *image, NSError *error, NSURL *imageURL))completed;

- (void)bl_setImageWithUrl:(NSURL *)imageUrl animated:(BOOL)animated;
- (void)bl_setImageWithUrl:(NSURL *)imageUrl animated:(BOOL)animated animationDuration:(CGFloat)animationDuration;
- (void)bl_setImageWithUrl:(NSURL *)imageUrl placeholderImage:(UIImage *)placeholderImage animated:(BOOL)animated animationDuration:(CGFloat)animationDuration completed:(void (^)(UIImage *image, NSError *error, NSURL *imageURL))completed;

+ (UIImageView *)bl_GifImageViewWithData:(NSData *)imageData;

@end
