//
//  NSObject+Invocation.m
//  JQCategories
//
//  Created by casa on 2017/3/29.
//  Copyright © 2017年 casa. All rights reserved.
//

#import "NSObject+Invocation.h"

@implementation NSObject (Invocation)

- (NSInvocation *)createInvocationWithSelector:(SEL)selector
{
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[[self class] instanceMethodSignatureForSelector:selector]];
    invocation.target = self;
    invocation.selector = selector;
    return invocation;
}

@end
