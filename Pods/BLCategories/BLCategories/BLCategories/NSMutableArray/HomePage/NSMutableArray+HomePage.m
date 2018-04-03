//
//  NSMutableArray+HomePage.m
//  BLCategories
//
//  Created by dch on 2017/4/10.
//  Copyright © 2017年 casa. All rights reserved.
//

#import "NSMutableArray+HomePage.h"

@implementation NSMutableArray (HomePage)

- (void)addFloor:(id)anObject
{
    if (anObject == nil) {
        return;
    }
    
    [self addObject:anObject];
}

- (void)insertFloor:(id)anObject atIndex:(NSUInteger)index
{
    if (anObject == nil) {
        return;
    }
    [self insertObject:anObject atIndex:index];
}

- (void)replaceFloorAtIndex:(NSUInteger)index withFloor:(id)anObject
{
    if (anObject == nil) {
        return;
    }
    [self replaceObjectAtIndex:index withObject:anObject];
}

@end
