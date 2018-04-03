//
//  BLImage.h
//  BLImage
//
//  Created by casa on 2017/7/27.
//  Copyright © 2017年 casa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+BLImage.h"
#import "UIButton+BLImage.h"

@interface iBLImage : NSObject

+ (UIImage  * _Nullable)imageNamed:(NSString * _Nullable)imageName;

+ (void)downloadImageWithURL:(NSURL * _Nullable)imageURL progress:(void (^ _Nullable)(CGFloat progress))progress completion:(void(^ _Nullable)(UIImage * _Nullable image, NSError * _Nullable error))completion;

+ (NSInteger)currentCacheSize;
+ (void)cleanCache;

@end
