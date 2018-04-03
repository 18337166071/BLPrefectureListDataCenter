//
//  UIView+FrameExtension.h
//  BLCategories
//
//  Created by sxg31 on 2017/3/13.
//  Copyright © 2017年 casa. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SCREENSZIE [UIScreen mainScreen].bounds.size
@interface UIView (FrameExtension)

@property (nonatomic, assign) CGFloat bl_x;
@property (nonatomic, assign) CGFloat bl_y;
@property (nonatomic, assign) CGFloat bl_centerX;
@property (nonatomic, assign) CGFloat bl_centerY;
@property (nonatomic, assign) CGFloat bl_width;
@property (nonatomic, assign) CGFloat bl_height;
@property (nonatomic, assign) CGSize bl_size;

@end
