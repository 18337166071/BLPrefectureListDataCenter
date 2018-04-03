//
//  NSString+Calculate.m
//  精度测试
//
//  Created by user on 17/3/7.
//  Copyright © 2017年 Charon. All rights reserved.
//

#import "NSString+Calculate.h"

@implementation NSString (Calculate)

- (NSString *)operationByType:(BLCalculateOperationType)operationType withValueString:(NSString *)valueString
{
    NSDecimalNumber *originNumber = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *operationNumber = [NSDecimalNumber decimalNumberWithString:valueString];
    
    if (operationType == BLCalculateOperationTypeAdding) {
        return [[originNumber decimalNumberByAdding:operationNumber] stringValue];
    }else if (operationType == BLCalculateOperationTypeSubtracting){
        return [[originNumber decimalNumberBySubtracting:operationNumber] stringValue];
    }else if (operationType == BLCalculateOperationTypeMultiplying){
        return [[originNumber decimalNumberByMultiplyingBy:operationNumber] stringValue];
    }else if (operationType == BLCalculateOperationTypeDividing){
        return [[originNumber decimalNumberByDividingBy:operationNumber] stringValue];
    }
    return nil;
}

- (BOOL)isEqualToStringValue:(NSString *)value
{
    return [self compareWithStringValue:value] == BLCompareResultSame;
}

- (BLCompareResult)compareWithStringValue:(NSString *)value
{
    NSDecimalNumber *originNumber = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *compareNumber = [NSDecimalNumber decimalNumberWithString:value];
    
    NSComparisonResult result = [originNumber compare:compareNumber];
    if (result == NSOrderedAscending) {
        return BLCompareResultAscending;
    }else if (result == NSOrderedSame){
        return BLCompareResultSame;
    }else{
        return BLCompareResultDescending;
    }
}

- (NSString *)accurateString
{
    NSString *doubleString = [NSString stringWithFormat:@"%lf", [self doubleValue]];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}

@end
