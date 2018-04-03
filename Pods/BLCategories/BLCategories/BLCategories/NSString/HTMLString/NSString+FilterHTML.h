//
//  NSString+FilterHTML.h
//  BLCategories
//
//  Created by Delano on 2017/4/24.
//  Copyright © 2017年 casa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FilterHTML)

/**
 删除html<><>标签

 @param str 元数据
 @return 格式化数据
 */
+ (NSString *)filterHTML:(NSString *)str;

+ (NSString *)filterHTMLImage:(NSString *)str;

+ (NSString *)filterHTMLTag:(NSString *)str;

@end
