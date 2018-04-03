//
//  UIImageView+PlaceHolder.m
//  BLCategories
//
//  Created by user on 2017/10/25.
//  Copyright © 2017年 casa. All rights reserved.
//

#import "UIImageView+PlaceHolder.h"
#import <BLImage/UIImageView+BLImage.h>

@implementation UIImageView (PlaceHolder)

- (void)ph_setImageWithUrl:(NSURL *)url
{
    UIImage *placeHolderImage = [UIImage imageNamed:@"hp_placeHodleImage"];
    self.contentMode = UIViewContentModeCenter;
    [self bl_setImageWithUrl:url placeholderImage:placeHolderImage completed:^(UIImage *image, NSError *error, NSURL *imageURL) {
        if (image != nil) {
            self.clipsToBounds = YES;
            self.contentMode = UIViewContentModeScaleToFill;
        }else{
            self.contentMode = UIViewContentModeCenter;
        }
    }];
}

@end
