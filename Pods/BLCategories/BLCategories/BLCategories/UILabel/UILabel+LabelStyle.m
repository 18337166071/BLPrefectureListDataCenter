//
//  UILabel+LabelStyle.m
//  BLCategories
//
//  Created by 张耀文 on 2017/3/7.
//  Copyright © 2017年 casa. All rights reserved.
//

#import "UILabel+LabelStyle.h"

@implementation UILabel (LabelStyle)

+(UILabel *)labelWithFont:(UIFont *)font color:(UIColor *)color textAlignment:(NSTextAlignment)alignment
{
    UILabel *label = [[UILabel alloc] init];
    label.font = font;
    label.textColor = color;
    label.textAlignment = alignment;
    
    return label;
}

+ (UILabel *)labelWithFontName:(NSString *)fontName fontSize:(CGFloat)fontSize color:(UIColor *)color textAlignment:(NSTextAlignment)alignment
{
    UIFont *font = [UIFont fontWithName:fontName size:fontSize];
    if (!font) {
        font = [UIFont systemFontOfSize:fontSize];
    }
    return [self labelWithFont:font color:color textAlignment:alignment];
}

@end
