//
//  NSObject+Networking.h
//  CTCategories
//
//  Created by casa on 2017/5/6.
//  Copyright © 2017年 casa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Networking)

- (NSString *)ipAddress:(BOOL)preferIPv4;
- (NSString *)ipStringFromAddressData:(NSData *)dataIn;

@end
