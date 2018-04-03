//
//  UIImage+Size.h
//  BLCategories
//
//  Created by user on 17/1/18.
//  Copyright © 2017年 casa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Size)

- (UIImage *)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

- (UIImage *)newImageWithSize:(CGSize)newSize;

@end
