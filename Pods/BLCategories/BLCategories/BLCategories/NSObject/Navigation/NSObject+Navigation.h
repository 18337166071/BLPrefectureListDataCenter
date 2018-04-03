//
//  NSObject+Navigation.h
//  JQCategories
//
//  Created by casa on 2017/3/30.
//  Copyright © 2017年 casa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSObject (Navigation)

- (UIViewController * _Nullable)topmostViewController;
- (void)jq_pushViewController:(UIViewController * _Nonnull)viewController animated:(BOOL)animated;
- (void)jq_presentViewController:(UIViewController * _Nonnull)viewControllerToPresent animated:(BOOL)animated completion:(void (^ __nullable)(void))completion;

@end
