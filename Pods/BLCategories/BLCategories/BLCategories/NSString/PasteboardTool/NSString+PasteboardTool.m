//
//  NSString+PasteboardTool.m
//  BLCategories
//
//  Created by 😈张耀文😈 on 2017/11/22.
//  Copyright © 2017年 casa. All rights reserved.
//

#import "NSString+PasteboardTool.h"

@implementation NSString (PasteboardTool)

- (void) sendToPasteboard
{
    [UIPasteboard generalPasteboard].string = self;
}

@end
