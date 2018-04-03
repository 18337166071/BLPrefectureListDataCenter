//
//  NSData+AES256.h
//  BLDaoJia
//
//  Created by 刘明杰 on 17/2/28.
//  Copyright © 2017年 百联. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CommonCrypto/CommonCrypto.h>

@interface NSData (AES256)

-(NSData *) aes256_encrypt:(NSString *)key;
-(NSData *) aes256_decrypt:(NSString *)key;

@end
