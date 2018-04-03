//
//  CTAppContext+BaiLian.m
//  CTAppContext_BaiLian
//
//  Created by casa on 2017/3/29.
//  Copyright © 2017年 casa. All rights reserved.
//

#import "CTAppContext+BaiLian.h"
#import <objc/runtime.h>
#import <BLSafeFetchDataFunctions/BLSafeFetchDataFunctions.h>

// 推送相关
static void * kBaiLianCTAppContextKeyDeviceToken = &kBaiLianCTAppContextKeyDeviceToken;
static void * kBaiLianCTAppContextKeyDeviceTokenData = &kBaiLianCTAppContextKeyDeviceTokenData;
static void * kBaiLianCTAppContextKeyJPushRegistrationID = &kBaiLianCTAppContextKeyJPushRegistrationID;

// 主站遗产
static void * kBaiLianCTAppContextKeyServiceCfg = &kBaiLianCTAppContextKeyServiceCfg;

//首页缓存相关
static void * kBaiLianCTAppContextKeyHomeCacheTime = &kBaiLianCTAppContextKeyHomeCacheTime;

@implementation CTAppContext (BaiLian)

- (NSString *)currentLevelName
{
    NSString *currentLevelName = @"普卡会员";
    if (self.memberLevel == 20) {
        currentLevelName = @"银卡会员";
    }
    if (self.memberLevel == 30) {
        currentLevelName = @"金卡会员";
    }
    if (self.memberLevel == 40) {
        currentLevelName = @"钻石会员";
    }
    return currentLevelName;
}

- (NSString *)nextLevelName
{
    NSString *nextLevelName = @"普卡会员";
    if (self.memberLevel == 10) {
        nextLevelName = @"银卡会员";
    }
    if (self.memberLevel == 20) {
        nextLevelName = @"金卡会员";
    }
    if (self.memberLevel == 30) {
        nextLevelName = @"钻石会员";
    }
    return nextLevelName;
}

- (NSInteger)memberLevel
{
    if (![self.userInfo[@"member_level"] isKindOfClass:[NSString class]]) {
        return 0;
    }
    return [self.userInfo[@"member_level"] integerValue];
}

- (NSURL *)memberAvatarUrl
{
    NSString *urlString = self.userInfo[@"avatarUrl"];
    if (![urlString isKindOfClass:[NSString class]]) {
        return nil;
    }
    NSURL *avatarUrl = [NSURL URLWithString:urlString];
    return avatarUrl;
}

- (NSString *)memberNickName
{
    NSString *nickname = nil;
    if ([self.userInfo[@"member_nickname"] length] > 0) {
        nickname = self.userInfo[@"member_nickname"];
    } else if ([self.userInfo[@"nickName"] length] > 0) {
        nickname = self.userInfo[@"nickName"];
    } else if ([self.userInfo[@"member_name"] length] > 0) {
        nickname = self.userInfo[@"member_name"];
    } else {
        nickname = self.memberMobilePhoneNumber;
    }
    return nickname;
}

- (NSString *)memberMobilePhoneNumber
{
    return stringFromObject(self.userInfo, @"mobile");
}

- (NSString *)memberToken
{
    return stringFromObject(self.userInfo, @"member_token");
}

- (NSString *)memberId
{
    return stringFromObject(self.userInfo, @"member_id");
}

- (NSString *)encodeMemberId
{
    return stringFromObject(self.userInfo, @"encode_memberId");
}

- (NSString *)memberName
{
    return stringFromObject(self.userInfo, @"member_name");
}

- (NSString *)ibl_appVersion
{
    // CFBundleShortVersionString
    return [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"];
}

#pragma mark - 百度推送相关
- (NSString *)channelSN
{
    NSString *channelSN = [[NSUserDefaults standardUserDefaults] stringForKey:@"channelId"];
    if (channelSN == nil) {
        channelSN = @"";
    }
    return channelSN;
}

#pragma mark - keychain
- (NSString *)UDIDName
{
    return @"BLUDIDName";
}

- (NSString *)keychainServiceName
{
    return @"BLKeychain";
}

#pragma mark - 推送相关
- (void)setDeviceToken:(NSString *)deviceToken
{
    objc_setAssociatedObject(self, kBaiLianCTAppContextKeyDeviceToken, deviceToken, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)deviceToken
{
    NSString *deviceToken = objc_getAssociatedObject(self, kBaiLianCTAppContextKeyDeviceToken);
    if (deviceToken == nil) {
        deviceToken = @"";
    }
    return deviceToken;
}

- (void)setDeviceTokenData:(NSData *)deviceTokenData
{
    objc_setAssociatedObject(self, kBaiLianCTAppContextKeyDeviceTokenData, deviceTokenData, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSData *)deviceTokenData
{
    NSData *deviceTokenData = objc_getAssociatedObject(self, kBaiLianCTAppContextKeyDeviceTokenData);
    if (deviceTokenData == nil) {
        deviceTokenData = [NSData data];
    }
    return deviceTokenData;
}

- (void)setJpushRegistrationID:(NSString *)jpushRegistrationID
{
    objc_setAssociatedObject(self, kBaiLianCTAppContextKeyJPushRegistrationID, jpushRegistrationID, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)jpushRegistrationID
{
    NSString *registrationID = objc_getAssociatedObject(self, kBaiLianCTAppContextKeyJPushRegistrationID);
    if (registrationID == nil) {
        registrationID = [[NSUserDefaults standardUserDefaults] stringForKey:@"JPUSHchannelId"];
    }
    if (registrationID == nil) {
        registrationID = @"";
    }
    return registrationID;
}

#pragma mark - 主站遗产
- (NSDictionary *)serviceCfg
{
    NSDictionary *serviveCfg = objc_getAssociatedObject(self, kBaiLianCTAppContextKeyServiceCfg);
    if (serviveCfg == nil) {
        serviveCfg = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"serviceCfg"];
    }
    return serviveCfg;
}

- (void)setServiceCfg:(NSDictionary *)serviceCfg
{
    objc_setAssociatedObject(self, kBaiLianCTAppContextKeyServiceCfg, serviceCfg, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark - 首页缓存时间相关
- (NSInteger)homeCacheTime
{
    NSNumber *cacheTime = objc_getAssociatedObject(self, kBaiLianCTAppContextKeyHomeCacheTime);
    if(cacheTime == nil)
        return 5 * 60;
    return [cacheTime integerValue] * 60;
}

- (void)setHomeCacheTime:(NSInteger)homeCacheTime
{
    objc_setAssociatedObject(self, kBaiLianCTAppContextKeyHomeCacheTime, @(homeCacheTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
