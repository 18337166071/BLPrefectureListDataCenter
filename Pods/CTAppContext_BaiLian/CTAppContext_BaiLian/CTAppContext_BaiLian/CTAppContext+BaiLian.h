//
//  CTAppContext+BaiLian.h
//  CTAppContext_BaiLian
//
//  Created by casa on 2017/3/29.
//  Copyright © 2017年 casa. All rights reserved.
//

#import <CTAppContext/CTAppContext.h>

@interface CTAppContext (BaiLian)

// 用户信息
@property (nonatomic, readonly) NSString *memberName;
@property (nonatomic, readonly) NSString *memberId;
@property (nonatomic, readonly) NSString *memberToken;
@property (nonatomic, readonly) NSInteger memberLevel;
@property (nonatomic, readonly) NSURL *memberAvatarUrl;
@property (nonatomic, readonly) NSString *memberMobilePhoneNumber;
@property (nonatomic, readonly) NSString *memberNickName;
@property (nonatomic, readonly) NSString *nextLevelName;
@property (nonatomic, readonly) NSString *currentLevelName;
@property (nonatomic, readonly) NSString *encodeMemberId;
@property (nonatomic, readonly) NSString *ibl_appVersion;

// 百度推送相关
@property (nonatomic, readonly) NSString *channelSN;

// keychain
@property (nonatomic, strong, readonly) NSString *UDIDName;
@property (nonatomic, strong, readonly) NSString *keychainServiceName;

// 推送相关
@property (nonatomic, copy) NSData *deviceTokenData;
@property (nonatomic, copy) NSString *deviceToken;
@property (nonatomic, copy) NSString *jpushRegistrationID;

// 主站遗产
@property (nonatomic, strong) NSDictionary *serviceCfg;

//首页缓存时间相关(秒)
@property (nonatomic, assign) NSInteger homeCacheTime;

// 用户信息
- (void)updateUserInfo:(NSDictionary *)userInfo;
- (void)cleanUserInfo;

@end
