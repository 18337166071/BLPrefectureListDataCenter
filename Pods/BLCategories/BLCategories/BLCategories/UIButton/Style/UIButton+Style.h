//
//  UIButton+Style.h
//  BLCategories
//
//  Created by 刘明杰 on 16/12/27.
//  Copyright © 2016年 casa. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, BLLayoutButtonStyle) {
    BLLayoutButtonStyleLeftImageRightTitle,
    BLLayoutButtonStyleLeftTitleRightImage,
    BLLayoutButtonStyleUpImageDownTitle,
    BLLayoutButtonStyleUpTitleDownImage
};

@interface UIButton (Style)

- (void)layoutButtonWithEdgeInsetsStyle:(BLLayoutButtonStyle)style
                        imageTitleSpace:(CGFloat)space;

@end
