//
//  IBLEmptyDataView.h
//  BaiLianMobileApp
//
//  Created by chuxiaolong on 16/3/15.
//  Copyright © 2016年 bailian. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^EmptyDataRefreshBlock)(void);


@interface IBLEmptyDataView : UIView


+ (instancetype)createEmptyDataViewWithRefreshBlock:(EmptyDataRefreshBlock)block;


+ (instancetype)createEmptyDataViewWithMessageText:(NSString*)messageText
                                              icon:(UIImage*)icon
                                      refreshBlock:(EmptyDataRefreshBlock)block;
    

+ (instancetype)createEmptyDataViewWithMessageText:(NSString *)messageText
                                           subText:(NSString*)subText
                                              icon:(UIImage *)icon
                                      refreshBlock:(EmptyDataRefreshBlock)block;
@end
