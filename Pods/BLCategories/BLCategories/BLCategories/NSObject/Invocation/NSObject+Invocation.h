//
//  NSObject+Invocation.h
//  JQCategories
//
//  Created by casa on 2017/3/29.
//  Copyright © 2017年 casa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Invocation)

- (NSInvocation *)createInvocationWithSelector:(SEL)selector;

@end
