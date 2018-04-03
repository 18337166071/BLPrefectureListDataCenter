//
//  UIViewController+NSInvocation.h
//  BLHomePage
//
//  Created by sxg31 on 2017/3/27.
//  Copyright © 2017年 bailian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSObject (UITableViewInvocationStrategy)

- (NSInvocation *)createInvocationWithSelector:(SEL)selector;
- (CGFloat)heightFromInvocation:(NSInvocation *)invocation data:(NSDictionary *)data;

@end
