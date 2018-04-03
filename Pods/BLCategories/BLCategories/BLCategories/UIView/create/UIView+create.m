//
//  UIView+create.m
//  BaiLianMobileApp
//
//  Created by dch on 16/3/17.
//  Copyright © 2016年 bailian. All rights reserved.
//

#import "UIView+create.h"

@implementation UIView (create)

+ (instancetype)autolayoutView
{
    UIView *view = [[self alloc] initWithFrame:CGRectZero];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    view.backgroundColor = [UIColor clearColor];
    return view;
}

+ (UIView *)duplicate:(UIView *)view
{
    NSData *tempArchive = [NSKeyedArchiver archivedDataWithRootObject:view];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}

@end
