//
//  UIImage+Scale.m
//  BLCategories
//
//  Created by user on 2017/9/25.
//  Copyright © 2017年 casa. All rights reserved.
//

#import "UIImage+Scale.h"

@implementation UIImage (Scale)

+ (UIImage *)bl_scaleImageWithOriginImage:(UIImage *)image
{
    // 如果图片尺寸超过350，先裁剪
    UIImage *cutImage;
    CGSize imgSize = image.size;
    if (imgSize.width > 350 || imgSize.height > 350) {
        CGFloat newWidth = 350;
        CGFloat newHeight = 350;
        if (newWidth > imgSize.width) {
            newWidth = imgSize.width;
        }
        if (newHeight > imgSize.height) {
            newHeight = imgSize.height;
        }
        CGRect rect = CGRectMake((imgSize.width-newWidth)/2, (imgSize.height-newHeight)/2, newWidth, newHeight);
        cutImage = [UIImage imageWithCGImage:CGImageCreateWithImageInRect([image CGImage], rect)];
    }
    else {
        cutImage = image;
    }
    
    // 再等比例缩小至150
    UIImage *scaleImage;
    CGSize oldSize = cutImage.size;
    if (oldSize.width > 150 || oldSize.height > 150) {
        CGFloat newWidth = 150;
        CGFloat newHeight = 150;
        if (oldSize.height > oldSize.width) {
            newWidth = newHeight / oldSize.height * oldSize.width;
        }
        else {
            newHeight = newWidth / oldSize.width * oldSize.height;
        }
        scaleImage = [self bl_riginImage:cutImage scaleToSize:CGSizeMake(newWidth, newHeight)];
    }
    else {
        scaleImage = cutImage;
    }
    return scaleImage;
}

+ (UIImage*)bl_riginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end
