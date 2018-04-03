//
//  UIColor+Helpers.h
//  FrameWork
//
//  Created by chuxiaolong on 15/8/9.
//  Copyright (c) 2015年 BST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)
+ (UIColor *)colorWithHex:(UInt32)hex;

+ (UIColor *)colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha;
+ (UIColor *)colorWithHex:(UInt32)hex alpha:(CGFloat)alpha;

+ (UIColor *)RandomColor;

+(UIColor *)colorWithHexStr:(NSString *)hexColor;

+(UIColor *)colorWithHexStr:(NSString *)hexColor alpha:(float)alpha;

@end
