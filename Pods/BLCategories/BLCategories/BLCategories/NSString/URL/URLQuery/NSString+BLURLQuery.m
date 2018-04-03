//
//  NSString+BLURLQuery.m
//  BLCategories
//
//  Created by casa on 2017/3/22.
//  Copyright © 2017年 casa. All rights reserved.
//

#import "NSString+BLURLQuery.h"

NSString * const kCTJSBridgeParamKeyCallbackIdentifier = @"callbackIdentifier";
NSString * const kCTJSBridgeParamKeyParams = @"data";
NSString * const kCTJSBridgeParamKeyTargetName = @"targetName";
NSString * const kCTJSBridgeParamKeyActionName = @"actionName";

@implementation NSString (BLURLQuery)

- (NSDictionary *)URLQuery_dictionary
{
    NSMutableDictionary *resultDictionary = (NSMutableDictionary *)[self BL_queryDictonary];
    
    NSError *error = nil;
    NSDictionary *param = [NSJSONSerialization JSONObjectWithData:[resultDictionary[kCTJSBridgeParamKeyParams] dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    if (!error && param) {
        resultDictionary[kCTJSBridgeParamKeyParams] = param;
    }

    return resultDictionary;
}

- (NSDictionary *)BL_queryDictonary
{
    NSMutableDictionary *resultDictionary = [[NSMutableDictionary alloc] init];
    
    NSArray *components = [self componentsSeparatedByString:@"&"];
    [components enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            NSArray *param = [obj componentsSeparatedByString:@"="];
            if ([param count] == 2) {
                NSString *key = param[0];
                NSString *encodedValue = param[1];
                
                NSString *decodedValue = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)encodedValue, CFSTR(""), kCFStringEncodingUTF8);
                resultDictionary[key] = decodedValue;
            }
        }
    }];
    return resultDictionary;
}

@end
