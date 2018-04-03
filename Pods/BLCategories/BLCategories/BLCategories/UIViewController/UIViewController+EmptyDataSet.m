//
//  UIViewController+EmptyDataSet.m
//  BaiLianMobileApp
//
//  Created by chuxiaolong on 16/3/15.
//  Copyright © 2016年 bailian. All rights reserved.
//

#import "UIViewController+EmptyDataSet.h"
#import <objc/runtime.h>
#import <HandyFrame/UIView+LayoutMethods.h>

static char emptyViewKey;

@implementation UIViewController (EmptyDataSet)

- (void)showEmptyDataViewWithrefreshBlock:(EmptyDataRefreshBlock)refreshBlock{
    [self showEmptyDataViewWithTopOffSet:0
                            bottomOffSet:0
                            refreshBlock:refreshBlock];
}

- (void)showEmptyDataViewWithTopOffSet:(CGFloat)topOffset
                          bottomOffSet:(CGFloat)bottomOffSet
                          refreshBlock:(EmptyDataRefreshBlock)refreshBlock{
    [self showEmptyDataViewWithTopOffSet:topOffset
                            bottomOffSet:bottomOffSet
                             messageText:nil
                                    icon:nil
                            refreshBlock:refreshBlock];
    
}

- (void)showEmptyDataViewWithMessageText:(NSString*)messageText
                                    icon:(UIImage*)image
                            refreshBlock:(EmptyDataRefreshBlock)refreshBlock{
    [self showEmptyDataViewWithTopOffSet:0
                            bottomOffSet:0
                             messageText:messageText
                                    icon:image
                            refreshBlock:refreshBlock];
}

- (void)showEmptyDataViewWithTopOffSet:(CGFloat)topOffset
                          bottomOffSet:(CGFloat)bottomOffSet
                           messageText:(NSString*)messageText
                                  icon:(UIImage*)image
                          refreshBlock:(EmptyDataRefreshBlock)refreshBlock{
    [self showEmptyDataViewWithTopOffSet:topOffset
                            bottomOffSet:bottomOffSet
                             messageText:messageText
                                 subText:nil
                                    icon:image
                            refreshBlock:refreshBlock];
}

- (void)showEmptyDataViewWithTopOffSet:(CGFloat)topOffset
                          bottomOffSet:(CGFloat)bottomOffSet
                           messageText:(NSString*)messageText
                               subText:(NSString*)subText
                                  icon:(UIImage*)image
                          refreshBlock:(EmptyDataRefreshBlock)refreshBlock{
    [self hideEmptyView];
    IBLEmptyDataView * emptyDataView = [IBLEmptyDataView createEmptyDataViewWithMessageText:messageText
                                                                                    subText:subText
                                                                                       icon:image
                                                                               refreshBlock:refreshBlock];
    [self.view addSubview:emptyDataView];
    
    objc_setAssociatedObject(self, &emptyViewKey, emptyDataView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [emptyDataView fillWidth];
    [emptyDataView topInContainer:[UIApplication sharedApplication].statusBarFrame.size.height + 44 +topOffset shouldResize:YES];
    [emptyDataView bottomInContainer:bottomOffSet shouldResize:YES];
}

- (void)showPureEmptyDataViewWithTopOffSet:(CGFloat)topOffset bottomOffSet:(CGFloat)bottomOffSet messageText:(NSString *)messageText subText:(NSString*)subText icon:(UIImage *)image
{
    [self showEmptyDataViewWithTopOffSet:topOffset bottomOffSet:bottomOffSet messageText:messageText subText:subText icon:image refreshBlock:nil];
    UIButton *resetButton = [[self emptyDataView] valueForKeyPath:@"resetButton"];
    resetButton.hidden = YES;
    
}
- (void)hideEmptyView{
    [[self emptyDataView] removeFromSuperview];
}

- (IBLEmptyDataView*)emptyDataView{
    return objc_getAssociatedObject(self, &emptyViewKey);
}

@end
