//
//  UIViewController+NSInvocation.m
//  BLHomePage
//
//  Created by sxg31 on 2017/3/27.
//  Copyright © 2017年 bailian. All rights reserved.
//

#import "NSObject+UITableViewInvocationStrategy.h"

@implementation NSObject (UITableViewInvocationStrategy)

- (NSInvocation *)createInvocationWithSelector:(SEL)selector
{
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[[self class] instanceMethodSignatureForSelector:selector]];
    invocation.target = self;
    invocation.selector = selector;
    return invocation;
}

- (CGFloat)heightFromInvocation:(NSInvocation *)invocation data:(NSDictionary *)data;
{
    [invocation setArgument:&data atIndex:2];
    [invocation invoke];
    CGFloat result;
    [invocation getReturnValue:&result];
    return result;
}
@end
