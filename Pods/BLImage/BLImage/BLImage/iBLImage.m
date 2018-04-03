//
//  BLImage.m
//  BLImage
//
//  Created by casa on 2017/7/27.
//  Copyright © 2017年 casa. All rights reserved.
//

#import "iBLImage.h"
#import <YYImage/YYImage.h>
#import <YYWebImage/YYWebImage.h>

@implementation iBLImage

+ (UIImage *)imageNamed:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];

    if (image == nil) {
        NSInteger scale = floor([UIScreen mainScreen].scale);
        NSURL *imagePathUrl = [[NSBundle mainBundle] URLForResource:imageName withExtension:@"webp"];

        BOOL shouldCheckAgain = NO;
        if ([[NSFileManager defaultManager] fileExistsAtPath:[imagePathUrl path]] == NO) {
            imagePathUrl = [[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"%@@%ldx", imageName, (long)scale] withExtension:@"webp"];
            shouldCheckAgain = YES;
        }
        
        if (shouldCheckAgain && [[NSFileManager defaultManager] fileExistsAtPath:[imagePathUrl path]] == NO) {
            return nil;
        }
        
        NSData *data = [NSData dataWithContentsOfURL:imagePathUrl];
        YYImageDecoder *decoder = [YYImageDecoder decoderWithData:data scale:1.0f];
        return [decoder frameAtIndex:0 decodeForDisplay:YES].image;
    }

    return image;
}

+ (NSInteger)currentCacheSize
{
    return [YYImageCache sharedCache].diskCache.totalCost;
}

+ (void)cleanCache
{
    [[YYImageCache sharedCache].diskCache removeAllObjects];
}

+ (void)downloadImageWithURL:(NSURL *)imageURL progress:(void (^)(CGFloat))progress completion:(void (^)(UIImage *, NSError *))completion
{
    [[YYWebImageManager sharedManager] requestImageWithURL:imageURL options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        CGFloat progressResult = (CGFloat)receivedSize / (CGFloat)expectedSize;
        if (progress) {
            progress(progressResult);
        }
    } transform:nil completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        if (completion) {
            completion(image, error);
        }
    }];
}

@end
