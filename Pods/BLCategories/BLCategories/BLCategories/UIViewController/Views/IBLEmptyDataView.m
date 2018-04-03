//
//  IBLEmptyDataView.m
//  BaiLianMobileApp
//
//  Created by chuxiaolong on 16/3/15.
//  Copyright © 2016年 bailian. All rights reserved.
//

#import "IBLEmptyDataView.h"
#import "UIColor+Hex.h"
#import <HandyFrame/UIView+LayoutMethods.h>
#import <AFNetworking/AFNetworkReachabilityManager.h>
#import "NSObject+Navigation.h"

NSString * const defaultImage = @"neterror";
NSString * const defaultTitle = @"抱歉，系统繁忙，请稍后再试！"; //edit by shiwanjun 修改默认展示文字
NSString * const defaultSubTitle = @"";

@interface IBLEmptyDataView()

@property (nullable, nonatomic, copy) EmptyDataRefreshBlock refreshBlock;

@property (nonatomic, strong) UIImageView * emptyTypeImageView;
@property (nonatomic, strong) UILabel     * messageLabel;
@property (nonatomic, strong) UILabel     * subTextLabel;
@property (nonatomic, strong) UIButton    * resetButton;
@property (nonatomic, strong) UIButton    * settingButton;

@end

@implementation IBLEmptyDataView

#pragma mark - life cycle

+ (instancetype)createEmptyDataViewWithRefreshBlock:(EmptyDataRefreshBlock)block{
    
    return [[IBLEmptyDataView alloc] initWithMessageText:nil icon:nil subText:nil refreshBlock:block];
}


+ (instancetype)createEmptyDataViewWithMessageText:(NSString*)messageText
                                              icon:(UIImage*)icon
                                      refreshBlock:(EmptyDataRefreshBlock)block{
    return [[IBLEmptyDataView alloc] initWithMessageText:messageText icon:icon subText:nil refreshBlock:block];
}

+ (instancetype)createEmptyDataViewWithMessageText:(NSString *)messageText
                                           subText:(NSString*)subText
                                              icon:(UIImage *)icon
                                      refreshBlock:(EmptyDataRefreshBlock)block{
    return [[IBLEmptyDataView alloc] initWithMessageText:messageText icon:icon subText:subText refreshBlock:block];
}

- (instancetype)initWithMessageText:(NSString*)messageText
                               icon:(UIImage*)image
                            subText:(NSString*)subText
                       refreshBlock:(EmptyDataRefreshBlock)block
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:251/255.0 green:251/255.0 blue:251/255.0 alpha:1];
        [self addSubview:self.emptyTypeImageView];
        [self addSubview:self.messageLabel];
        [self addSubview:self.subTextLabel];
        [self addSubview:self.resetButton];
        [self addSubview:self.settingButton];
        [self configureWithText:messageText subText:subText icon:image refreshBlock:block];
        
        //edit by shiwanjun start  添加检测网络状态，网络不佳时，修改提示文字
        AFNetworkReachabilityManager *manager =  [AFNetworkReachabilityManager sharedManager];
        [manager startMonitoring];
        
        __weak typeof(self) weakSelf = self;
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            if (status == AFNetworkReachabilityStatusNotReachable ||
                status == AFNetworkReachabilityStatusUnknown) {
                NSString *networkingeMessageText = @"很抱歉，您的网络状态不佳，请求页面超时！";
                [weakSelf configureWithText:networkingeMessageText subText:subText icon:image refreshBlock:block];
            }
            [weakSelf setNeedsLayout];
        }];
        //edit by shiwanjun end
    }
    return self;
}

- (void)configureWithText:(NSString*)messageText subText:(NSString*)subText icon:(UIImage*)image refreshBlock:(EmptyDataRefreshBlock)refreshBlock{
    self.emptyTypeImageView.image = image?image:[UIImage imageNamed:defaultImage];
    self.messageLabel.text = messageText?messageText:defaultTitle;
    self.subTextLabel.text = subText?subText:defaultSubTitle;
    self.refreshBlock = refreshBlock;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//        CGFloat whRatio = 750.0f/535.0f;
//        [self.emptyTypeImageView fillWidth];
//        self.emptyTypeImageView.ct_height = self.emptyTypeImageView.ct_width / whRatio;
//        [self.emptyTypeImageView topInContainer:kHPercentage(0) shouldResize:NO];
    
    self.emptyTypeImageView.ct_width = kWPercentage(100);
    self.emptyTypeImageView.ct_height = kHPercentage(105.5);
    [self.emptyTypeImageView topInContainer:kHPercentage(143) shouldResize:NO];
    [self.emptyTypeImageView centerXEqualToView:self];
    
    [self.subTextLabel sizeToFit];
    [self.subTextLabel centerXEqualToView:self];
    [self.subTextLabel top:0 FromView:self.emptyTypeImageView];
    
    [self.messageLabel sizeToFit];
    [self.messageLabel top:15 FromView:self.subTextLabel];
    [self.messageLabel centerXEqualToView:self];
    
    BOOL isReachable = [self isReachable];
    self.settingButton.hidden = !isReachable;
    
    CGFloat buttonWidth = isReachable ? 130.f : 150.f;
    CGFloat buttonHeight = 34.f;
    
    [self.resetButton setCt_size:CGSizeMake(buttonWidth, buttonHeight)];
    [self.resetButton top:40 FromView:self.messageLabel];
    
    [self.settingButton setCt_size:CGSizeMake(buttonWidth, buttonHeight)];
    [self.settingButton top:40 FromView:self.messageLabel];
    
    if (!isReachable) {
       [self.resetButton centerXEqualToView:self];
    }else{
        CGFloat spadding = (self.ct_width - buttonWidth * 2 - 10) / 2;
        [self.resetButton leftInContainer:spadding shouldResize:NO];
        [self.settingButton leftInContainer:self.resetButton.ct_right + 10.f shouldResize:NO];
        
    }
}

- (BOOL)isReachable
{
    AFNetworkReachabilityStatus status = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
    if (status == AFNetworkReachabilityStatusNotReachable ||
        status == AFNetworkReachabilityStatusUnknown) {
        return YES;
    }
    return NO;
}

#pragma mark - event response

- (void)didTappedResetButton:(UIButton *)button
{
    if (self.refreshBlock) {
        self.refreshBlock();
    }
    [self removeFromSuperview];
}

/**
 跳转至设置网络提示页面
 */
- (void)didTappedSettingButton:(UIButton *)button
{
    /**
     *  BLNetworkSettingViewController 页面详见组件BLNetworkOffTips
     *  使用Class初始化目的BLNetworkOffTips中引用本组件，导致重复引用，
     *  如果拆分EmptyView为组件，则代价太大，需要在原有使用的基础上全部替换。
     */
    Class networkSettingViewControllerClass = NSClassFromString(@"BLNetworkSettingViewController");
    UIViewController *networkSettingViewController = [[networkSettingViewControllerClass alloc] init];
    if ([networkSettingViewController isKindOfClass:[UIViewController class]] &&
        networkSettingViewController != nil) {
        [self jq_pushViewController:networkSettingViewController animated:YES];
    }
}

#pragma mark - getters and setters
- (UIImageView *)emptyTypeImageView
{
    if (_emptyTypeImageView == nil) {
        _emptyTypeImageView = [[UIImageView alloc] init];
    }
    return _emptyTypeImageView;
}

- (UILabel *)messageLabel
{
    if (_messageLabel == nil) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.textColor = [UIColor colorWithHex:0x999999];
        _messageLabel.font = [UIFont systemFontOfSize:14];
    }
    return _messageLabel;
}

- (UILabel *)subTextLabel
{
    if (_subTextLabel == nil) {
        _subTextLabel = [[UILabel alloc] init];
        _subTextLabel.textColor = [UIColor colorWithHex:0x666666];
        _subTextLabel.font = [UIFont systemFontOfSize:12];
    }
    return _subTextLabel;
}

- (UIButton *)resetButton
{
    if (_resetButton == nil) {
        _resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _resetButton.titleLabel.font = [UIFont systemFontOfSize:kHPercentage(12)];
        _resetButton.titleLabel.textColor = [UIColor colorWithHex:0x999999];
        
        _resetButton.layer.borderColor = [UIColor colorWithHex:0xCCCCCC].CGColor;
        _resetButton.layer.borderWidth = 0.5f;
        
        [_resetButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_resetButton setTitle:@"刷新一下试试" forState:UIControlStateNormal];
        [_resetButton setImage:[UIImage imageNamed:@"empty_refresh"] forState:UIControlStateNormal];
        [_resetButton addTarget:self action:@selector(didTappedResetButton:) forControlEvents:UIControlEventTouchUpInside];
        _resetButton.imageEdgeInsets = UIEdgeInsetsMake(0,0,0, 10);
    }
    return _resetButton;
}

- (UIButton *)settingButton
{
    if (_settingButton == nil) {
        _settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _settingButton.titleLabel.font = [UIFont systemFontOfSize:kHPercentage(12)];
        _settingButton.titleLabel.textColor = [UIColor colorWithHex:0xFFB1B1];
    
        _settingButton.layer.borderColor = [UIColor colorWithHex:0xFFB1B1].CGColor;
        _settingButton.layer.borderWidth = 0.5f;
        
        [_settingButton setTitleColor:[UIColor colorWithHex:0xFF6F6F] forState:UIControlStateNormal];
        [_settingButton setTitle:@"去设置网络" forState:UIControlStateNormal];
        [_settingButton addTarget:self action:@selector(didTappedSettingButton:) forControlEvents:UIControlEventTouchUpInside];
        _settingButton.hidden = YES;
    }
    return _settingButton;
}


@end
