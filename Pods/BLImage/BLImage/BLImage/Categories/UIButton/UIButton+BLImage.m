//
//  UIButton+BLImage.m
//  BLImage
//
//  Created by casa on 2017/7/27.
//  Copyright © 2017年 casa. All rights reserved.
//

#import "UIButton+BLImage.h"
#import <YYWebImage/UIButton+YYWebImage.h>

@implementation UIButton (BLImage)
- (void)bl_setBackgroundImageWithURL:(NSURL *)imageUrl forState:(UIControlState)state
{
    [self yy_setBackgroundImageWithURL:imageUrl forState:state placeholder:nil];
}

- (void)bl_setBackgroundImageWithURL:(NSURL *)imageUrl forState:(UIControlState)state placeholderImage:(UIImage *)placeholderImage
{
    [self yy_setBackgroundImageWithURL:imageUrl forState:state placeholder:placeholderImage];
}

- (void)bl_setImageWithURL:(NSURL *)imageUrl forState:(UIControlState)state
{
    [self bl_setImageWithURL:imageUrl forState:state animated:NO animationDuration:0];
}

- (void)bl_setImageWithURL:(NSURL *)imageUrl forState:(UIControlState)state animated:(BOOL)animated
{
    [self bl_setImageWithURL:imageUrl forState:state animated:animated animationDuration:0.3f];
}


- (void)bl_setImageWithURL:(NSURL *)imageUrl forState:(UIControlState)state animated:(BOOL)animated animationDuration:(CGFloat)animationDuration
{
    if (animated) {
        self.alpha = 0.0f;
    }

    __weak typeof(self) weakSelf = self;
    [self yy_setImageWithURL:imageUrl
                    forState:state
                 placeholder:nil
                     options:0
                  completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
                      __strong typeof(weakSelf) strongSelf = weakSelf;
                      [strongSelf setImage:image forState:state];
                      if (animated) {
                          [UIView animateWithDuration:animationDuration animations:^{
                              strongSelf.alpha = 1.0f;
                          }];
                      }
                  }];
}

- (void)bl_setImageWithURL:(NSURL *)imageUrl forState:(UIControlState)state placeholderImage:(UIImage *)placeholderImage
{
    [self yy_setImageWithURL:imageUrl forState:state placeholder:placeholderImage];
}

- (void)bl_setImageWithURL:(NSURL *)imageUrl forState:(UIControlState)state placeholderImage:(UIImage *)placeholderImage animated:(BOOL)animated animationDuration:(CGFloat)animationDuration completed:(void (^)(UIImage *image, NSError *error, NSURL *imageURL))completed
{
    __weak typeof(self) weakSelf = self;
    [self yy_setImageWithURL:imageUrl
                    forState:state
                 placeholder:placeholderImage
                     options:0
                  completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
                      __strong typeof(weakSelf) strongSelf = weakSelf;
                      if (image) {
                            [strongSelf setImage:image forState:state];
                          
                          if (animated&&(from != YYWebImageFromMemoryCache)) {
                              strongSelf.alpha = 0.0f;
                              [UIView animateWithDuration:animationDuration animations:^{
                                  strongSelf.alpha = 1.0f;
                              }];
                          }
                      }
                      if (completed) {
                          completed(image, error, url);
                      }
                      
                  }];
}
@end
