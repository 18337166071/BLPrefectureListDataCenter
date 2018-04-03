//
//  UIViewController+EmptyDataSet.h
//  BaiLianMobileApp
//
//  Created by chuxiaolong on 16/3/15.
//  Copyright © 2016年 bailian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IBLEmptyDataView.h"

@interface UIViewController (EmptyDataSet)

- (void)showEmptyDataViewWithrefreshBlock:(EmptyDataRefreshBlock)refreshBlock;

/**
 *  使用默认图片和默认文字
 *
 *  @param topOffset    至navigationBar的边距
 *  @param bottomOffSet 至Tabbar的边距
 *  @param refreshBlock 点击空视图回调代码块
 */
- (void)showEmptyDataViewWithTopOffSet:(CGFloat)topOffset
                          bottomOffSet:(CGFloat)bottomOffSet
                          refreshBlock:(EmptyDataRefreshBlock)refreshBlock;



//使用默认的边距 上下都是0
- (void)showEmptyDataViewWithMessageText:(NSString*)messageText
                                    icon:(UIImage*)image
                            refreshBlock:(EmptyDataRefreshBlock)refreshBlock;

/**
 *  使用自定义的图片和文字
 *
 *  @param topOffset    至navigationBar的边距
 *  @param bottomOffSet 至Tabbar的边距
 *  @param messageText  自定义空视图显示文字
 *  @param image        空视图显示图片
 *  @param refreshBlock action回调Block
 */

- (void)showEmptyDataViewWithTopOffSet:(CGFloat)topOffset
                          bottomOffSet:(CGFloat)bottomOffSet
                           messageText:(NSString*)messageText
                                  icon:(UIImage*)image
                          refreshBlock:(EmptyDataRefreshBlock)refreshBlock;


- (void)showEmptyDataViewWithTopOffSet:(CGFloat)topOffset
                          bottomOffSet:(CGFloat)bottomOffSet
                           messageText:(NSString*)messageText
                               subText:(NSString*)subText
                                  icon:(UIImage*)image
                          refreshBlock:(EmptyDataRefreshBlock)refreshBlock;

- (void)showPureEmptyDataViewWithTopOffSet:(CGFloat)topOffset
                              bottomOffSet:(CGFloat)bottomOffSet
                               messageText:(NSString*)messageText
                                   subText:(NSString*)subText
                                      icon:(UIImage*)image;//无按钮及点击事件

- (void)hideEmptyView;

@end
