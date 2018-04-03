//
//  NSString+Extension.h
//  iBaiLianDemo
//
//  Created by dch on 15/12/11.
//  Copyright © 2015年 BaiLian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (IBLExtension)

/**
 * 返回值是该字符串所占的大小(width, height)
 *font : 该字符串所用的字体(字体大小不一样,显示出来的面积也不同)
 *maxSize : 为限制改字体的最大宽和高(如果显示一行,则宽高都设置为MAXFLOAT, 如果显示为多行,只需将宽设置一个有限定长值,高设置为MAXFLOAT)
 */
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

/**
 * 根据字典转换url请求 格式www.baidu.com?key1=value1&key2=value2
 * @param dict 需拼接字段
 */
-(NSString *)convertUrlWithDict:(NSDictionary *)dict;
//判断密码强度
+ (int) judgePasswordStrength:(NSString*) _password;

//判断手机号码格式是否正确
+ (BOOL)valiMobile:(NSString *)mobile;
//判断密码格式
+(BOOL)valiCode:(NSString *)code;
//将毫秒值转化为日期可格式字符串
+ (NSString *)ConvertStrToTime:(NSString *)timeStr;

+ (NSString *)outputDateStringWithInputDateString:(NSString *)inputDateString inputFormat:(NSString *)inputFormat outputFormat:(NSString *)outputFormat;

- (NSString *)VerticalString;


/**
 浮点字符串 * 100

 @param string 字符串
 @return 返回值
 */
+ (NSString *)decimalNumberByMultiplying100ByStirng:(NSString *)string;

@end
