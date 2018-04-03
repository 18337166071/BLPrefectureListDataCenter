//
//  NSString+Utility.m
//  BLCategories
//
//  Created by chengwei on 2017/1/9.
//  Copyright © 2017年 casa. All rights reserved.
//

#import "NSString+Utility.h"

@implementation NSString (Utility)

//!!!!: 校验手机号
/**
 *  校验手机号
 *
 *  @param mobileNum 入参string
 *
 *  @return 返回bool
 */
+ (BOOL)validateMobile:(NSString *)mobileNum
{
//    NSString *strExpression = @"(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strExpression];
//    return [predicate evaluateWithObject:mobileNum];
    return mobileNum.length == 11;
}

//!!!!: 校验姓名
/**
 *  校验姓名
 *
 *  @param name 入参string
 *
 *  @return 返回bool
 */
+ (BOOL)validateName:(NSString *)name{
    NSString *strExpression = @"[\u4e00-\u9fa5]{1,15}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strExpression];
    return [predicate evaluateWithObject:name];
}
+ (BOOL)validateName:(NSString *)name minLength:(NSInteger)minLength maxLength:(NSInteger)maxLength
{
    NSString *strExpression = [NSString stringWithFormat:@"[\u4e00-\u9fa5]{%zd,%zd}",minLength,maxLength];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strExpression];
    return [predicate evaluateWithObject:name];
}
//!!!!: 校验身份证号码
/**
 *  校验身份证号码
 *
 *  @param IDCard 入参string
 *
 *  @return 返回bool
 */
+ (BOOL)validateIDCard:(NSString *)IDCard
{
    NSString *strExpression;
    if (IDCard.length == 15) {
        strExpression = @"[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$";
    }else{
        strExpression = @"[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strExpression];
    return [predicate evaluateWithObject:[IDCard uppercaseString]];
}

//!!!!: 判断固定电话
/**
 *  判断固定电话
 *
 *  @param phoneNum 手机号码
 *
 *  @return YES / NO
 */
+ (BOOL)validatePhoneTel:(NSString *)phoneNum
{
    
    //先判断位数
    if (phoneNum.length == 11 || phoneNum.length == 12 || phoneNum.length == 13)
    {
        NSString *strLine = @"-";
        NSString *str1 = [[phoneNum substringFromIndex:2] substringToIndex:1];
        NSString *str2 = [[phoneNum substringFromIndex:3] substringToIndex:1];
        //        NSLog(@"str1 = %@\n str2 = %@",str1,str2);
        if ([str1 isEqualToString:strLine] || [str2 isEqualToString:strLine])
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    else
    {
        return NO;
    }
}

//!!!!:  姓名部分隐藏
/**
 *	@brief	 姓名部分隐藏
 *
 *	@param 	name 	姓名
 *
 *	@return 李*妖
 */
+ (NSString *)secureName:(NSString *)name
{
    if (name.length == 2) {
        NSString *newName = [NSString stringWithFormat:@"%@*",[name substringToIndex:1]];
        return newName;
    } else if (name.length > 2) {
        NSMutableString *star = [NSMutableString string];
        for (int i = 0; i < name.length - 2; i++) {
            [star appendString:@"*"];
        }
        NSString *newName = [NSString stringWithFormat:@"%@%@%@",[name substringToIndex:1],star,[name substringFromIndex:name.length - 1]];
        return newName;
    }
    return name;
}

//!!!!: 隐藏电话号码
/**
 *	@brief	隐藏电话号码
 *
 *	@param 	pNum 	电话号码
 *
 *	@return 186****1325
 */

+ (NSString *)securePhoneNumber:(NSString *)pNum
{
    if (pNum.length != 11)
    {
        return pNum;
    }
    NSString *result = [NSString stringWithFormat:@"%@ **** %@",[pNum substringToIndex:3],[pNum substringFromIndex:7]];
    return result;
}

//!!!!: 隐藏身份证号码
/**
 *	@brief	隐藏身份证号码
 *
 *	@param 	IdNum 	身份证号码
 *
 *	@return 4211**********1325
 */
+ (NSString *)secureIdCard:(NSString *)IdNum
{
    if (IdNum.length != 18)
    {
        return IdNum;
    }
    NSString *result = [NSString stringWithFormat:@"%@**********%@",[IdNum substringToIndex:4],[IdNum substringFromIndex:IdNum.length - 4]];
    return result;
}

//!!!!: 银行卡每四位加空格
/**
 *  银行卡每四位加空格
 *
 *  @param bankCard 银行卡号
 *
 *  @return 1234 5678 9098 7654
 */
+ (NSString *)manageBankCard:(NSString *)bankCard{
    NSMutableString *bankCardNum = [NSMutableString stringWithString:bankCard];
    for (int i = 0; i < bankCard.length; i ++) {
        if (i > 0 && (i + 1) % 4 == 0) {
            [bankCardNum insertString:@" " atIndex:i+ (i + 1)/4];
        }
    }
    return bankCardNum;
    
}

//!!!!: 限制输入框只能输入数字
/**
 *  限制输入框只能输入数字
 *
 *  @param number 输入
 *
 *  @return YES / NO
 */
+ (BOOL)printInNumber:(NSString*)number
{
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

//!!!!: 限制输入框只能输入字母和数字组合
/**
 *  限制输入框只能输入字母和数字组合
 *
 *  @param str 输入
 *
 *  @return YES / NO
 */
+ (BOOL)printInLettersOrNumber:(NSString*)str
{
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ"];
    int i = 0;
    while (i < str.length) {
        NSString * string = [str substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

//!!!!: 限制输入框只能输入字母
/**
 *  限制输入框只能输入字母
 *
 *  @param str 输入
 *
 *  @return YES / NO
 */
+ (BOOL)printInLetters:(NSString*)str
{
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ"];
    int i = 0;
    while (i < str.length) {
        NSString * string = [str substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

//!!!!: 限制特殊字符不能输入
/**
 *  限制输入框只能输入字母和数字组合
 *
 *  @param stringText 限制字符
 *
 *  @return YES / NO
 */
+ (int)XZInputText:(NSString *)stringText
{
    NSCharacterSet *nameCharacters = [NSCharacterSet
                                      characterSetWithCharactersInString:@"`~!@#$%^&*()+=|{}':;',\\[\\].<>?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？"];
    NSRange userNameRange = [stringText rangeOfCharacterFromSet:nameCharacters];
    
    if (userNameRange.location != NSNotFound) {
        return 0;//包含特殊字符
    }else{
        return 1;
    }
    return 1;
}

/**
 验证邮箱

 @param email email
 @return return value
 */
+ (BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

@end
