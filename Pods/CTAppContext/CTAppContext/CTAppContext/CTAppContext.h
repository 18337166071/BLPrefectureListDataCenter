//
//  AXRuntimeInfomation.h
//  RTNetworking
//
//  Created by casa on 14-5-6.
//  Copyright (c) 2014年 casatwy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CTServiceAPIEnviroment) {
    CTServiceAPIEnviromentNotSetted,
    CTServiceAPIEnviromentDevelop,
    CTServiceAPIEnviromentPreRelease,
    CTServiceAPIEnviromentRelease,
};

extern NSString * const kCTAppContextUserDefaultKeyUserInfo;

@interface CTAppContext : NSObject

//凡是未声明成readonly的都是需要在初始化的时候由外面给的

// 设备信息
@property (nonatomic, copy, readonly) NSString *mobileType;
@property (nonatomic, copy, readonly) NSString *model;
@property (nonatomic, copy, readonly) NSString *deviceModel;
@property (nonatomic, copy, readonly) NSString *os;
@property (nonatomic, copy, readonly) NSString *rom;
@property (nonatomic, copy, readonly) NSString *ppi;
@property (nonatomic, copy, readonly) NSString *UUIDString;
@property (nonatomic, copy, readonly) NSString *deviceName;
@property (nonatomic, assign, readonly) CGSize resolution;

// 运行环境相关
@property (nonatomic, assign, readonly) BOOL isReachable;
@property (nonatomic, assign) CTServiceAPIEnviroment apiEnviroment;
@property (nonatomic, assign) CGFloat requestTimeoutSecond;

// 用户token相关
@property (nonatomic, copy, readonly) NSString *accessToken;
@property (nonatomic, copy, readonly) NSString *tokenKey;
@property (nonatomic, assign, readonly) NSTimeInterval lastRefreshTime;

// 用户信息
@property (nonatomic, copy) NSDictionary *userInfo;
- (void)updateUserInfo:(NSDictionary *)userInfo;
- (void)cleanUserInfo;

// app信息
@property (nonatomic, copy, readonly) NSString *sessionId; // 每次启动App时都会新生成
@property (nonatomic, readonly) NSString *appVersion;
@property (nonatomic, readonly) NSString *appId;
@property (nonatomic, readonly) NSString *appName;
@property (nonatomic, readonly) NSString *requestTime;
@property (nonatomic, readonly) NSString *timestampString;
@property (nonatomic, readonly) NSString *sysid;
@property (nonatomic, assign) BOOL shouldPrintNetworkingLog;
@property (nonatomic, readonly) NSString *iPAddress;

// 地理位置
@property (nonatomic, assign, readonly) CGFloat latitude;
@property (nonatomic, assign, readonly) CGFloat longitude;

// category需要覆盖的内容
@property (nonatomic, strong, readonly) NSString *memberToken;
@property (nonatomic, strong, readonly) NSString *channelSN;
@property (nonatomic, strong, readonly) NSString *UDIDName;
@property (nonatomic, strong, readonly) NSString *keychainServiceName;

+ (instancetype)sharedInstance;

// 动态降级相关
- (BOOL)shouldDownGradeAPIWithAPIMethodName:(NSString *)methodName pageName:(NSString *)pageName;
- (NSArray <NSString *> *)modulesToPresentInPage:(NSString *)pageName;

// 访问token相关

- (void)updateWithAccessInfo:(NSDictionary *)accessInfo;
- (void)cleanAccessToken;

// 应用生命周期
- (void)appStarted;
- (void)appEnded;

@end
