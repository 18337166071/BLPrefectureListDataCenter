//
//  NSString+Utility.h
//  BLCategories
//
//  Created by chengwei on 2017/1/9.
//  Copyright © 2017年 casa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utility)

//校验手机号
+ (BOOL)validateMobile:(NSString *)mobileNum;

//校验姓名
+ (BOOL)validateName:(NSString *)name;
+ (BOOL)validateName:(NSString *)name minLength:(NSInteger)minLength maxLength:(NSInteger)maxLength;
//校验身份证号码
+ (BOOL)validateIDCard:(NSString *)IDCard;

//判断固话
+ (BOOL)validatePhoneTel:(NSString *)phoneNum;

// 姓名部分隐藏
+ (NSString *)secureName:(NSString *)name;

// 手机号部分隐藏
+ (NSString *)securePhoneNumber:(NSString *)pNum;

// 身份证号部分隐藏
+ (NSString *)secureIdCard:(NSString *)IdNum;

// 银行卡每四位加空格
+ (NSString *)manageBankCard:(NSString *)bankCard;

//限制输入框只能输入数字
+ (BOOL)printInNumber:(NSString*)number;

//限制输入框只能输入字母和数字组合
+ (BOOL)printInLettersOrNumber:(NSString*)str;

//限制输入框只能输入字母
+ (BOOL)printInLetters:(NSString*)str;

//判断不能输入特殊字符
+(int) XZInputText:(NSString *) stringText;

//判断邮箱格式
+(BOOL)isValidateEmail:(NSString *)email;

@end
