//
//  NSString+AES256.h
//  BLDaoJia
//
//  Created by 刘明杰 on 17/2/28.
//  Copyright © 2017年 百联. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import <CommonCrypto/CommonDigest.h>
//#import <CommonCrypto/CommonCryptor.h>

#import "NSData+AES256.h"

@interface NSString (AES256)

-(NSString *) aes256_encrypt:(NSString *)key;
-(NSString *) aes256_decrypt:(NSString *)key;

@end
