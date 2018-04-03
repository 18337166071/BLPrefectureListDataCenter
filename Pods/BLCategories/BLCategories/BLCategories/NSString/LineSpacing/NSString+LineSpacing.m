//
//  NSString+LineSpacing.m
//  BLCategories
//
//  Created by 张耀文 on 2017/3/7.
//  Copyright © 2017年 casa. All rights reserved.
//

#import "NSString+LineSpacing.h"

@implementation NSString (LineSpacing)

+ (NSAttributedString *)attrubtedStringWithString:(NSString *)string LineSpacing:(CGFloat )lineSpacing
{
    NSMutableAttributedString *attrubtedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];//调整行间距
    [attrubtedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
    return [attrubtedString copy];
}

@end
