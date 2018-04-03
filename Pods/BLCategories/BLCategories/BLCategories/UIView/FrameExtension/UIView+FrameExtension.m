//
//  UIView+FrameExtension.m
//  BLCategories
//
//  Created by sxg31 on 2017/3/13.
//  Copyright © 2017年 casa. All rights reserved.
//

#import "UIView+FrameExtension.h"

@implementation UIView (FrameExtension)

- (void)setBl_x:(CGFloat)bl_x
{
    CGRect frame = self.frame;
    frame.origin.x = bl_x;
    self.frame = frame;
}

- (void)setBl_y:(CGFloat)bl_y
{
    CGRect frame = self.frame;
    frame.origin.y = bl_y;
    self.frame = frame;
}

- (CGFloat)bl_x
{
  return self.frame.origin.x;
}

- (CGFloat)bl_y
{
  return self.frame.origin.y;
}

- (void)setBl_centerX:(CGFloat)bl_centerX
{
    CGPoint center = self.center;
    center.x = bl_centerX;
    self.center = center;
}

- (CGFloat)bl_centerX
{
   return self.center.x;
}

- (void)setBl_centerY:(CGFloat)bl_centerY
{
    CGPoint center = self.center;
    center.y = bl_centerY;
    self.center = center;
}

- (CGFloat)bl_centerY
{
   return self.center.y;
}

- (void)setBl_width:(CGFloat)bl_width
{
    CGRect frame = self.frame;
    frame.size.width = bl_width;
    self.frame = frame;
}

- (CGFloat)bl_width
{
    return self.frame.size.width;
}

- (void)setBl_height:(CGFloat)bl_height
{
    CGRect frame = self.frame;
    frame.size.height = bl_height;
    self.frame = frame;
}

- (CGFloat)bl_height
{
   return self.frame.size.height;
}

- (void)setBl_size:(CGSize)bl_size
{
    CGRect frame = self.frame;
    frame.size = bl_size;
    self.frame = frame;
}

- (CGSize)bl_size
{
 return self.frame.size;
}
@end
