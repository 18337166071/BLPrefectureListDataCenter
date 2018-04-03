//
//  UIView+ViewController.m
//  BLCategories
//
//  Created by casa on 2017/5/2.
//  Copyright © 2017年 casa. All rights reserved.
//

#import "UIView+ViewController.h"

@implementation UIView (ViewController)

- (UIViewController *)relatedViewController
{
    UIViewController *relatedViewController = (UIViewController *)[self traverseResponderChainForUIViewController];
    return relatedViewController;
}

- (id)traverseResponderChainForUIViewController {
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return nextResponder;
    } else if ([nextResponder isKindOfClass:[UIView class]]) {
        return [nextResponder traverseResponderChainForUIViewController];
    } else {
        return nil;
    }
}

@end
