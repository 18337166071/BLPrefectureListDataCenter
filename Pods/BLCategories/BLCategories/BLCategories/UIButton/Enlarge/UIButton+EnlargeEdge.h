//
//  UIButton+EnlargeEdge.h
//  BaiLianMobileApp
//
//  Created by chengwei on 16/7/15.
//  Copyright © 2016年 bailian. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  扩大UIButton点击区域
 */
@interface UIButton (EnlargeEdge)
- (void)setEnlargeEdge:(CGFloat) size;
- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;
@end
