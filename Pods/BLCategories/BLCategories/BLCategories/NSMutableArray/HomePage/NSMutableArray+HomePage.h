//
//  NSMutableArray+HomePage.h
//  BLCategories
//
//  Created by dch on 2017/4/10.
//  Copyright © 2017年 casa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (HomePage)

- (void)addFloor:(id)anObject;

- (void)insertFloor:(id)anObject atIndex:(NSUInteger)index;

- (void)replaceFloorAtIndex:(NSUInteger)index withFloor:(id)anObject;

@end
