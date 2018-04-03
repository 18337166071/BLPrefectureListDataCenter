//
//  NSString+BLURLEncode.m
//  BLCategories
//
//  Created by 刘明杰 on 17/3/9.
//  Copyright © 2017年 casa. All rights reserved.
//

#import "NSString+BLURLEncode.h"

@implementation NSString (BLURLEncode)

- (NSString *)urlencodeString:(NSStringEncoding)encoding
{
    CFStringRef cfUrlEncodedString = CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                             (CFStringRef)self,NULL,
                                                                             (CFStringRef)@"!#$%&'()*+,/:;=?@[]",
                                                                             kCFStringEncodingUTF8);
    
    NSString *urlEncoded = [NSString stringWithString:(__bridge NSString *)cfUrlEncodedString];
    CFRelease(cfUrlEncodedString);
    return urlEncoded;
}

@end
