//
//  NSString+Size.h
//  BaiLianMobileApp
//
//  Created by chuxiaolong on 16/4/12.
//  Copyright © 2016年 bailian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Size)

- (CGSize)stringSizeWithContentSize:(CGSize)contentSize font:(UIFont *)font;
- (CGSize)sizeWithContentSize:(CGSize)contentSize font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing;
- (CGFloat)heightWithFont:(UIFont *)font width:(CGFloat)width;

@end
