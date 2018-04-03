//
//  NSData+Base64.h
//
//  Created by Fujita Taiuke on 12/03/04.
//  Copyright (c) 2012 Revolution9. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSData(BLBase64)

- (nullable NSString *)bl_base64EncodedString;

+ (nullable NSString*)decodeBase64String:(nullable NSString * )input;
@end
