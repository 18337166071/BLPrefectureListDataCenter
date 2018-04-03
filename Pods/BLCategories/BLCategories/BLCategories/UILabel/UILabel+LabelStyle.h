//
//  UILabel+LabelStyle.h
//  BLCategories
//
//  Created by 张耀文 on 2017/3/7.
//  Copyright © 2017年 casa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LabelStyle)

+(UILabel *)labelWithFont:(UIFont *)font color:(UIColor *)color textAlignment:(NSTextAlignment)alignment;

+(UILabel *)labelWithFontName:(NSString *)fontName fontSize:(CGFloat)fontSize color:(UIColor *)color textAlignment:(NSTextAlignment)alignment;

@end
