//
//  UIView+create.h
//  BaiLianMobileApp
//
//  Created by dch on 16/3/17.
//  Copyright © 2016年 bailian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (create)

/**
 *  生成一个frame = CGRectZero的 View，并设置translatesAutoresizingMaskIntoConstraints = NO
 *  backgroundcolor=[uicolor clear]
 *  @return view
 */
+ (instancetype)autolayoutView;

/**
 *  完全复制一个view
 *
 *  @param view 需要复制的view
 *
 *  @return 复制的view
 */
+ (UIView *)duplicate:(UIView *)view;

@end
