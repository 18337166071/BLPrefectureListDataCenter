//
//  NSString+Extension.m
//  iBaiLianDemo
//
//  Created by dch on 15/12/11.
//  Copyright © 2015年 BaiLian. All rights reserved.
//

#import "NSString+IBLExtension.h"

@implementation NSString (IBLExtension)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (NSString *)convertUrlWithDict:(NSDictionary *)dict {
    if (!dict) {
        return @"";
    }
    
    NSMutableString *url = [NSMutableString string];
    for (int i = 0; i < dict.count; i ++) {
        NSString *string;
        if (i == 0) {
            string = [NSString stringWithFormat:@"?%@=%@", dict.allKeys[i], dict[dict.allKeys[i]]];
        } else {
            string = [NSString stringWithFormat:@"&%@=%@", dict.allKeys[i], dict[dict.allKeys[i]]];
        }
        [url appendString:string];
    }
    return url;
}
//判断是否包含

+ (BOOL) judgeRange:(NSArray*) _termArray Password:(NSString*) _password

{
    NSRange range;
    BOOL result =NO;
    for(int i=0; i<[_termArray count]; i++)
    {
        range = [_password rangeOfString:[_termArray objectAtIndex:i]];
        if(range.location != NSNotFound)
        {
            result =YES;
        }
    }
    return result;
}

//条件
+ (int) judgePasswordStrength:(NSString*) _password

{
    //全是数学和特殊字符.
    BOOL result0 = [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^(?![0-9]+$)(?![^A-Za-z0-9]+$)[^A-Za-z]{8,20}$"] evaluateWithObject:_password];
    //全是字符和特殊字符.
    BOOL result1 = [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^(?![^A-Za-z0-9]+$)(?![a-zA-Z]+$)[^0-9]{8,20}$"] evaluateWithObject:_password];
    //全是数字加字母.
    BOOL result2 = [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,20}$"] evaluateWithObject:_password];
    //字母 数字 特殊字符
    BOOL result3 = [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"(?![0-9a-zA-Z]+$)(?![0-9~!@#$%^&*()+=|{}':;',\\[\\].<>?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？]+$)(?![a-zA-Z~!@#$%^&*()+=|{}':;',\\[\\].<>?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？]+$)[0-9A-Za-z~!@#$%^&*()+=|{}':;',\\[\\].<>?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？]{8,20}$"] evaluateWithObject:_password];
    //密码强度低，建议修改
    int result = 1;
    if (result0 || result1 || result2) {
        //密码强度一般
        result = 2;
    }
    if (result3) {
        //密码强度高
        result = 3;
    }
    
    return result;
}
//判断手机号码格式是否正确
+ (BOOL)valiMobile:(NSString *)mobile
{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11 )
    {
        return NO;
    }else{
//        /**
//         * 移动号段正则表达式
//         */
//        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
//        /**
//         * 联通号段正则表达式
//         */
//        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
//        /**
//         * 电信号段正则表达式
//         */
//        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
//        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
//        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
//        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
//        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
//        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
//        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
       
        
        if ([[mobile substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"]) {
            return YES;
        }else{
            return NO;
        }
    }
}
+(BOOL)valiCode:(NSString *)code
{
    BOOL result = false;
    //全是数学和特殊字符.
    BOOL result0 = [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^(?![0-9]+$)(?![^A-Za-z0-9]+$)[^A-Za-z]{8,20}$"] evaluateWithObject:code];
    //全是字符和特殊字符.
    BOOL result1 = [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^(?![^A-Za-z0-9]+$)(?![a-zA-Z]+$)[^0-9]{8,20}$"] evaluateWithObject:code];
    //全是数字加字母.
    BOOL result2 = [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,20}$"] evaluateWithObject:code];
    //字母 数字 特殊字符
    BOOL result3 = [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"(?![0-9a-zA-Z]+$)(?![0-9~!@#$%^&*()+=|{}':;',\\[\\].<>?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？]+$)(?![a-zA-Z~!@#$%^&*()+=|{}':;',\\[\\].<>?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？]+$)[0-9A-Za-z~!@#$%^&*()+=|{}':;',\\[\\].<>?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？]{8,20}$"] evaluateWithObject:code];
    if (result0 || result1 || result2 || result3) {
        result = YES;
    }
    return result;
}


+ (NSString *)ConvertStrToTime:(NSString *)timeStr{
    
    long long time=[timeStr longLongValue];
    
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000.0];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"HH:mm:ss"];
    
    NSString*timeString=[formatter stringFromDate:d];
    
    return timeString;
    
}

+ (NSString *)outputDateStringWithInputDateString:(NSString *)inputDateString inputFormat:(NSString *)inputFormat outputFormat:(NSString *)outputFormat
{
    if ([inputFormat isEqualToString:@"timeStemp"]) {
        NSTimeInterval time = [inputDateString doubleValue];
        if (inputDateString.length == 13) {
            time = [inputDateString doubleValue] / 1000;
        }
        NSDate *detailDate = [NSDate dateWithTimeIntervalSince1970:time];
        
        //实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:outputFormat];
        
        NSString *dateStr = [dateFormatter stringFromDate:detailDate];
        return dateStr;
        
    }
    else
    {
        NSDateFormatter *informat = [[NSDateFormatter alloc]init];
        [informat setDateFormat:inputFormat];
        NSDate *date = [informat dateFromString:inputDateString];
        NSDateFormatter *outformat = [[NSDateFormatter alloc]init];
        [outformat setDateFormat:outputFormat];
        return [outformat stringFromDate:date];
    }
}


- (NSString *)VerticalString{
    NSMutableString * str = [[NSMutableString alloc] initWithString:self];
    NSInteger count = str.length;
    for (int i = 1; i < count; i ++) {
        [str insertString:@"\n" atIndex:i*2 - 1];
    }
    return str;
}

+ (NSString *)decimalNumberByMultiplying100ByStirng:(NSString *)string
{
    if (string.length == 0 || string == nil || string == 0) {
        return @"0";
    }
    ///订单金额：单位元
    NSDecimalNumber * rawString = [NSDecimalNumber decimalNumberWithString:string];
    ///基数100  Decimal
    NSDecimalNumber * multiplyNumber = [NSDecimalNumber decimalNumberWithString:@"100"];
    ///订单金额：单位分
    NSDecimalNumber * newString = [rawString decimalNumberByMultiplyingBy:multiplyNumber];
    
    return [NSString stringWithFormat:@"%.ld",[newString integerValue]];
}

@end
