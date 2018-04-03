//
//  NSString+Calculate.h
//  精度测试
//
//  Created by user on 17/3/7.
//  Copyright © 2017年 Charon. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BLCalculateOperationType){
    BLCalculateOperationTypeAdding,       //加
    BLCalculateOperationTypeSubtracting,  //减
    BLCalculateOperationTypeMultiplying,  //乘
    BLCalculateOperationTypeDividing,     //除
};

typedef NS_ENUM(NSInteger, BLCompareResult){
    BLCompareResultAscending,  //小于
    BLCompareResultSame,       //等于
    BLCompareResultDescending, //大于
};

@interface NSString (Calculate)

/**
 运算函数

 @param operationType 操作类型(加，减, 乘， 除)
 @param valueString 运算值
 @return 运算后的字符串（该字符串只可以显示或者提交 如果需要运算再通过该方法运算 不可在外部转floatValue运算）
 */
- (NSString *)operationByType:(BLCalculateOperationType)operationType withValueString:(NSString *)valueString;

/**
 比较两个字符串 value是否相等

 @param value 比较字符串
 @return YES 相等 NO，不相等
 */
- (BOOL)isEqualToStringValue:(NSString *)value;

/**
 比较两个字符串的Value

 @param value 比较值
 @return BLCompareResult
 */
- (BLCompareResult)compareWithStringValue:(NSString *)value;


/**
 把有误差的浮点型字符串转换为精确的数字

 @return 返回精确的数字
 */
- (NSString *)accurateString;

@end
