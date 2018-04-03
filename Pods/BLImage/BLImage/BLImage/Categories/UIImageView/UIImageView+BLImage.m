//
//  UIImageView+BLImage.m
//  BLImage
//
//  Created by casa on 2017/7/27.
//  Copyright © 2017年 casa. All rights reserved.
//

#import "UIImageView+BLImage.h"

@implementation UIImageView (BLImage)

- (void)bl_setImageWithUrl:(NSURL *)imageUrl
{
    [self bl_setImageWithUrl:imageUrl animated:NO animationDuration:0];
}

- (void)bl_setImageWithUrl:(NSURL *)imageUrl animated:(BOOL)animated
{
    [self bl_setImageWithUrl:imageUrl animated:animated animationDuration:0.2f];
}

- (void)bl_setImageWithUrl:(NSURL *)imageUrl animated:(BOOL)animated animationDuration:(CGFloat)animationDuration
{
    __weak typeof(self) weakSelf = self;
    [self yy_setImageWithURL:imageUrl
                 placeholder:nil
                     options:0
                  completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
                      __strong typeof(weakSelf) strongSelf = weakSelf;
                      if (animated && (from == YYWebImageFromRemote || from == YYWebImageFromDiskCache) ) {
                          strongSelf.alpha = 0.0f;
                          [UIView animateWithDuration:animationDuration animations:^{
                              strongSelf.alpha = 1.0f;
                          }];
                      }
                  }];
}

- (void)bl_setImageWithUrl:(NSURL *)imageUrl placeholderImage:(UIImage *)placeholderImage completed:(void (^)(UIImage *, NSError *, NSURL *))completed
{
    [self yy_setImageWithURL:imageUrl
                 placeholder:placeholderImage
                     options:0
                  completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
                      if (completed) {
                          completed(image, error, url);
                      }
                  }];
}

- (void)bl_setImageWithUrl:(NSURL *)imageUrl placeholderImage:(UIImage *)placeholderImage
{
    [self yy_setImageWithURL:imageUrl placeholder:placeholderImage];
    
}

- (void)bl_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(YYWebImageOptions)options completed:(void (^)(UIImage *image, NSError *error, NSURL *imageURL))completed
{
    [self yy_setImageWithURL:url placeholder:placeholder options:options completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        if (completed) {
            completed(image, error, url);
        }
    }];
}

- (void)bl_setImageWithUrl:(NSURL *)imageUrl placeholderImage:(UIImage *)placeholderImage animated:(BOOL)animated animationDuration:(CGFloat)animationDuration completed:(void (^)(UIImage *image, NSError *error, NSURL *imageURL))completed
{
    __weak typeof(self) weakSelf = self;
    [self yy_setImageWithURL:imageUrl
                 placeholder:placeholderImage
                     options:0
                  completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
                      __strong typeof(weakSelf) strongSelf = weakSelf;
                      if (animated && (from == YYWebImageFromRemote || from == YYWebImageFromDiskCache) ) {
                          strongSelf.alpha = 0.0f;
                          [UIView animateWithDuration:animationDuration animations:^{
                              strongSelf.alpha = 1.0f;
                          }];
                      }
                      if (completed) {
                          completed(image, error, url);
                      }
                  }];
}

+ (UIImageView *)bl_GifImageViewWithData:(NSData *)imageData
{
    YYImage *image = [YYImage imageWithData:imageData];
    UIImageView *resultImageView = [[YYAnimatedImageView alloc] initWithImage:image];
    return resultImageView;
}

@end
