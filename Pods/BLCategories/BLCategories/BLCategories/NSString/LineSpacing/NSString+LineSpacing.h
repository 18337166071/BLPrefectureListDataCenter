//
//  NSString+LineSpacing.h
//  BLCategories
//
//  Created by 张耀文 on 2017/3/7.
//  Copyright © 2017年 casa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (LineSpacing)

+ (NSAttributedString *)attrubtedStringWithString:(NSString *)string LineSpacing:(CGFloat)lineSpacing;

@end
