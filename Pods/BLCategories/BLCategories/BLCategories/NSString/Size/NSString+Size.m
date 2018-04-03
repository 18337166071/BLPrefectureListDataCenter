//
//  NSString+Size.m
//  BaiLianMobileApp
//
//  Created by chuxiaolong on 16/4/12.
//  Copyright © 2016年 bailian. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

- (CGSize)stringSizeWithContentSize:(CGSize)contentSize font:(UIFont *)font
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary *attributes = @{NSFontAttributeName: font,NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize size = [self boundingRectWithSize:contentSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return size;
}

- (CGSize)sizeWithContentSize:(CGSize)contentSize font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.lineSpacing = lineSpacing;
    
    NSDictionary *attributes = @{NSFontAttributeName: font,NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize size = [self boundingRectWithSize:contentSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return size;
}

- (CGFloat)heightWithFont:(UIFont *)font width:(CGFloat)width
{
    CGSize constrainSize = CGSizeMake(width, CGFLOAT_MAX);
    CGRect rect = [self boundingRectWithSize:constrainSize
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:@{NSFontAttributeName:font}
                                     context:nil];
    return rect.size.height;
}

@end
