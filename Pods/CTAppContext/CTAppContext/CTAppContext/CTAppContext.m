//
//  AXRuntimeInfomation.m
//  RTNetworking
//
//  Created by casa on 14-5-6.
//  Copyright (c) 2014年 casatwy. All rights reserved.
//

#import "CTAppContext.h"
#import "CTLocationManager.h"
#import <AFNetworking/AFNetworkReachabilityManager.h>
#import <BLSafeFetchDataFunctions/BLSafeFetchDataFunctions.h>
#import <BLBusinessCategoryAPIManager/BLMediator+APIManager.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#include <sys/types.h>
#include <sys/sysctl.h>

NSString * const kCTAppContextUserDefaultKeyUserInfo = @"kCTAppContextUserDefaultKeyUserInfo";
NSString * const kCTAppContextUserDefaultKeyTokenKey = @"kCTAppContextUserDefaultKeyTokenKey";
NSString * const kCTAppContextUserDefaultKeyAccessInfo = @"openapi_access_info";
NSString * const kCTAppContextUserDefaultKeyAPIDownGradeInfo = @"kCTAppContextUserDefaultKeyAPIDownGradeInfo";
NSString * const kCTAppContextUserDefaultKeyModuleDownGradeInfo = @"kCTAppContextUserDefaultKeyModuleDownGradeInfo";

@interface CTAppContext ()

// 用户的token管理
@property (nonatomic, copy, readwrite) NSString *accessToken;
@property (nonatomic, copy, readwrite) NSString *tokenKey;
@property (nonatomic, assign, readwrite) NSTimeInterval lastRefreshTime;

// app 信息
@property (nonatomic, copy, readwrite) NSString *sessionId; // 每次启动App时都会新生成,用于日志标记
@property (nonatomic, strong) NSDictionary *apiDownGradeInfo;
@property (nonatomic, strong) NSDictionary *moduleDownGradeInfo;

@end

@implementation CTAppContext

@synthesize apiEnviroment = _apiEnviroment;

#pragma mark - public methods
+ (instancetype)sharedInstance
{
    static CTAppContext *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CTAppContext alloc] init];
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.requestTimeoutSecond = 20.0f;
    }
    return self;
}

#pragma mark - public methods
- (void)updateWithAccessInfo:(NSDictionary *)accessInfo;
{
    self.lastRefreshTime = [[NSDate date] timeIntervalSince1970] * 1000;
    
    [[NSUserDefaults standardUserDefaults] setValue:accessInfo forKey:kCTAppContextUserDefaultKeyAccessInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)cleanAccessToken
{
    self.accessToken = nil;
    self.tokenKey = nil;
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCTAppContextUserDefaultKeyAccessInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - getters and setters


- (NSString *)accessToken
{
    return stringFromObject([[NSUserDefaults standardUserDefaults] valueForKey:kCTAppContextUserDefaultKeyAccessInfo], @"accessToken");
}

- (NSString *)tokenKey
{
    return stringFromObject([[NSUserDefaults standardUserDefaults] valueForKey:kCTAppContextUserDefaultKeyAccessInfo], @"tokenKey");
}

- (NSString *)mobileType
{
    return @"ios";
}

- (NSString *)model
{
    return [[UIDevice currentDevice] name];
}

- (NSString *)deviceModel
{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    if([platform isEqualToString:@"iPhone1,1"])return@"iPhone 2G";
    if([platform isEqualToString:@"iPhone1,2"])return@"iPhone 3G";
    if([platform isEqualToString:@"iPhone2,1"])return@"iPhone 3GS";
    if([platform isEqualToString:@"iPhone3,1"])return@"iPhone 4";
    if([platform isEqualToString:@"iPhone3,2"])return@"iPhone 4";
    if([platform isEqualToString:@"iPhone3,3"])return@"iPhone 4";
    if([platform isEqualToString:@"iPhone4,1"])return@"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone6";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone6Plus";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone6sPlus";
    if ([platform isEqualToString:@"iPhone8,3"]) return @"iPhoneSE";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhoneSE";
    if ([platform isEqualToString:@"iPhone9,1"])    return @"iPhone 7 (CDMA)";
    if ([platform isEqualToString:@"iPhone9,3"])    return @"iPhone 7 (GSM)";
    if ([platform isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus (CDMA)";
    if ([platform isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus (GSM)";
    if([platform isEqualToString:@"iPhone10,1"])return@"iPhone 8";
    if([platform isEqualToString:@"iPhone10,4"])return@"iPhone 8";
    if([platform isEqualToString:@"iPhone10,2"])return@"iPhone 8 Plus";
    if([platform isEqualToString:@"iPhone10,5"])return@"iPhone 8 Plus";
    if([platform isEqualToString:@"iPhone10,3"])return@"iPhone X";
    if([platform isEqualToString:@"iPhone10,6"])return@"iPhone X";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
}

- (NSString *)os
{
    return [[UIDevice currentDevice] systemVersion];
}

- (NSString *)rom
{
    return [[UIDevice currentDevice] model];
}

- (NSString *)UUIDString
{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

- (NSString *)deviceName
{
    return [[UIDevice currentDevice] name];
}

- (BOOL)isReachable
{
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusUnknown) {
        return YES;
    } else {
        return [[AFNetworkReachabilityManager sharedManager] isReachable];
    }
}

- (NSString *)ppi
{
    NSString *ppi = @"";
    if ([self.deviceName isEqualToString:@"iPod1,1"] ||
        [self.deviceName isEqualToString:@"iPod2,1"] ||
        [self.deviceName isEqualToString:@"iPod3,1"] ||
        [self.deviceName isEqualToString:@"iPhone1,1"] ||
        [self.deviceName isEqualToString:@"iPhone1,2"] ||
        [self.deviceName isEqualToString:@"iPhone2,1"]) {
        
        ppi = @"163";
    }
    else if ([self.deviceName isEqualToString:@"iPod4,1"] ||
             [self.deviceName isEqualToString:@"iPhone3,1"] ||
             [self.deviceName isEqualToString:@"iPhone3,3"] ||
             [self.deviceName isEqualToString:@"iPhone4,1"]) {
        
        ppi = @"326";
    }
    else if ([self.deviceName isEqualToString:@"iPhone5,1"] ||
             [self.deviceName isEqualToString:@"iPhone5,2"] ||
             [self.deviceName isEqualToString:@"iPhone5,3"] ||
             [self.deviceName isEqualToString:@"iPhone5,4"] ||
             [self.deviceName isEqualToString:@"iPhone6,1"] ||
             [self.deviceName isEqualToString:@"iPhone6,2"]) {
        
        ppi = @"326";
    }
    else if ([self.deviceName isEqualToString:@"iPhone7,1"]) {
        ppi = @"401";
    }
    else if ([self.deviceName isEqualToString:@"iPhone7,2"]) {
        ppi = @"326";
    }
    else if ([self.deviceName isEqualToString:@"iPad1,1"] ||
             [self.deviceName isEqualToString:@"iPad2,1"]) {
        ppi = @"132";
    }
    else if ([self.deviceName isEqualToString:@"iPad3,1"] ||
             [self.deviceName isEqualToString:@"iPad3,4"] ||
             [self.deviceName isEqualToString:@"iPad4,1"] ||
             [self.deviceName isEqualToString:@"iPad4,2"]) {
        ppi = @"264";
    }
    else if ([self.deviceName isEqualToString:@"iPad2,5"]) {
        ppi = @"163";
    }
    else if ([self.deviceName isEqualToString:@"iPad4,4"] ||
             [self.deviceName isEqualToString:@"iPad4,5"]) {
        ppi = @"326";
    }
    else {
        ppi = @"264";
    }
    return ppi;
}

- (CGSize)resolution
{
    CGSize resolution = CGSizeZero;
    if ([self.deviceName isEqualToString:@"iPod1,1"] ||
        [self.deviceName isEqualToString:@"iPod2,1"] ||
        [self.deviceName isEqualToString:@"iPod3,1"] ||
        [self.deviceName isEqualToString:@"iPhone1,1"] ||
        [self.deviceName isEqualToString:@"iPhone1,2"] ||
        [self.deviceName isEqualToString:@"iPhone2,1"]) {
        
        resolution = CGSizeMake(320, 480);
    }
    else if ([self.deviceName isEqualToString:@"iPod4,1"] ||
             [self.deviceName isEqualToString:@"iPhone3,1"] ||
             [self.deviceName isEqualToString:@"iPhone3,3"] ||
             [self.deviceName isEqualToString:@"iPhone4,1"]) {
        
        resolution = CGSizeMake(640, 960);
    }
    else if ([self.deviceName isEqualToString:@"iPhone5,1"] ||
             [self.deviceName isEqualToString:@"iPhone5,2"] ||
             [self.deviceName isEqualToString:@"iPhone5,3"] ||
             [self.deviceName isEqualToString:@"iPhone5,4"] ||
             [self.deviceName isEqualToString:@"iPhone6,1"] ||
             [self.deviceName isEqualToString:@"iPhone6,2"]) {
        
        resolution = CGSizeMake(640, 1136);
    }
    else if ([self.deviceName isEqualToString:@"iPhone7,1"]) {
        resolution = CGSizeMake(1080, 1920);
    }
    else if ([self.deviceName isEqualToString:@"iPhone7,2"]) {
        resolution = CGSizeMake(750, 1334);
    }
    else if ([self.deviceName isEqualToString:@"iPad1,1"] ||
             [self.deviceName isEqualToString:@"iPad2,1"]) {
        resolution = CGSizeMake(768, 1024);
    }
    else if ([self.deviceName isEqualToString:@"iPad3,1"] ||
             [self.deviceName isEqualToString:@"iPad3,4"] ||
             [self.deviceName isEqualToString:@"iPad4,1"] ||
             [self.deviceName isEqualToString:@"iPad4,2"]) {
        resolution = CGSizeMake(1536, 2048);
    }
    else if ([self.deviceName isEqualToString:@"iPad2,5"]) {
        resolution = CGSizeMake(768, 1024);
    }
    else if ([self.deviceName isEqualToString:@"iPad4,4"] ||
             [self.deviceName isEqualToString:@"iPad4,5"]) {
        resolution = CGSizeMake(1536, 2048);
    }
    else {
        resolution = CGSizeMake(640, 960);
    }
    return resolution;
}

- (NSString *)appVersion
{
  return [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
}

- (NSString *)appId
{
    return [[NSBundle mainBundle] bundleIdentifier];
}

- (CGFloat)latitude
{
    return [CTLocationManager sharedInstance].currentLocation.coordinate.latitude;
}

- (CGFloat)longitude
{
    return [CTLocationManager sharedInstance].currentLocation.coordinate.longitude;
}

- (void)appStarted
{
    self.sessionId = [[NSUUID UUID].UUIDString copy];
    [[CTLocationManager sharedInstance] startLocation];
//    [[BLMediator sharedInstance] loadModuleDownGradeInfo:^(NSDictionary *downGradeInfo) {
//        self.moduleDownGradeInfo = downGradeInfo;
//        [[NSUserDefaults standardUserDefaults] setObject:downGradeInfo forKey:kCTAppContextUserDefaultKeyModuleDownGradeInfo];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }];
//    [[BLMediator sharedInstance] loadAPIDownGradeInfo:^(NSDictionary *downGradeInfo) {
//        self.apiDownGradeInfo = downGradeInfo;
//        [[NSUserDefaults standardUserDefaults] setObject:downGradeInfo forKey:kCTAppContextUserDefaultKeyAPIDownGradeInfo];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }];
}

- (void)appEnded
{
    [[CTLocationManager sharedInstance] stopLocation];
}

- (void)setApiEnviroment:(CTServiceAPIEnviroment)apiEnviroment
{
    _apiEnviroment = apiEnviroment;
    [[NSUserDefaults standardUserDefaults] setInteger:apiEnviroment forKey:@"CTServiceAPIEnviroment"];
    
    if (_apiEnviroment == CTServiceAPIEnviromentDevelop) {
        [[NSUserDefaults standardUserDefaults] setObject:@"[Develop]" forKey:@"CTAPIEnvironment"];
        return ;
    }
    if (_apiEnviroment == CTServiceAPIEnviromentRelease) {
        [[NSUserDefaults standardUserDefaults] setObject:@"[Release]" forKey:@"CTAPIEnvironment"];
        return ;
    }
    if (_apiEnviroment == CTServiceAPIEnviromentPreRelease) {
        [[NSUserDefaults standardUserDefaults] setObject:@"[PRE Release]" forKey:@"CTAPIEnvironment"];
        return ;
    }
    [[NSUserDefaults standardUserDefaults] setObject:@"[ApiEnv not known]" forKey:@"CTAPIEnvironment"];
}

- (CTServiceAPIEnviroment)apiEnviroment
{
    if (_apiEnviroment == CTServiceAPIEnviromentNotSetted) {
        _apiEnviroment = [[NSUserDefaults standardUserDefaults] integerForKey:@"CTServiceAPIEnviroment"];
    }
    
    if (_apiEnviroment == CTServiceAPIEnviromentNotSetted) {
        _apiEnviroment = CTServiceAPIEnviromentDevelop;
        [[NSUserDefaults standardUserDefaults] setInteger:_apiEnviroment forKey:@"CTServiceAPIEnviroment"];
        [[NSUserDefaults standardUserDefaults] setObject:@"[Develop]" forKey:@"CTAPIEnvironment"];
    }
    
    return _apiEnviroment;
}

- (NSString *)appName
{
    return [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
}

- (NSString *)requestTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    return [formatter stringFromDate:[NSDate date]];
}

- (NSString *)timestampString
{
    return [NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970]];
}

- (NSString *)sysid
{
    return @"1103";
}

- (NSString *)iPAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}
- (BOOL)shouldDownGradeAPIWithAPIMethodName:(NSString *)methodName pageName:(NSString *)pageName
{
    BOOL result = NO;

    if ([self.apiDownGradeInfo[@"all"] isKindOfClass:[NSDictionary class]]) {
        result = self.apiDownGradeInfo[@"all"][methodName] ? YES : NO;
        return result;
    }

    if ([self.apiDownGradeInfo[pageName] isKindOfClass:[NSDictionary class]]) {
        result = self.apiDownGradeInfo[pageName][methodName] ? YES : NO;
        return result;
    }
    
    return result;
}

- (NSArray<NSString *> *)modulesToPresentInPage:(NSString *)pageName
{
    if ([self.moduleDownGradeInfo isKindOfClass:[NSDictionary class]]) {
        return self.moduleDownGradeInfo[pageName];
    }
    return nil;
}

- (NSDictionary *)apiDownGradeInfo
{
    if (_apiDownGradeInfo == nil) {
        _apiDownGradeInfo = [[NSUserDefaults standardUserDefaults] dictionaryForKey:kCTAppContextUserDefaultKeyAPIDownGradeInfo];
    }
    return _apiDownGradeInfo;
}

- (NSDictionary *)moduleDownGradeInfo
{
    if (_moduleDownGradeInfo == nil) {
        _moduleDownGradeInfo = [[NSUserDefaults standardUserDefaults] dictionaryForKey:kCTAppContextUserDefaultKeyModuleDownGradeInfo];
    }
    return _moduleDownGradeInfo;
}

- (NSString *)memberToken
{
    NSLog(@"warning! 不应该跑到这个方法:%@ %s，需要在对应的category中覆盖!", [self class], __FUNCTION__);
    NSLog(@"warning! 不应该跑到这个方法:%@ %s，需要在对应的category中覆盖!", [self class], __FUNCTION__);
    NSLog(@"warning! 不应该跑到这个方法:%@ %s，需要在对应的category中覆盖!", [self class], __FUNCTION__);
    NSLog(@"warning! 不应该跑到这个方法:%@ %s，需要在对应的category中覆盖!", [self class], __FUNCTION__);
    NSLog(@"warning! 不应该跑到这个方法:%@ %s，需要在对应的category中覆盖!", [self class], __FUNCTION__);
    NSLog(@"warning! 不应该跑到这个方法:%@ %s，需要在对应的category中覆盖!", [self class], __FUNCTION__);
    NSLog(@"warning! 不应该跑到这个方法:%@ %s，需要在对应的category中覆盖!", [self class], __FUNCTION__);
    NSLog(@"warning! 不应该跑到这个方法:%@ %s，需要在对应的category中覆盖!", [self class], __FUNCTION__);
    NSLog(@"warning! 不应该跑到这个方法:%@ %s，需要在对应的category中覆盖!", [self class], __FUNCTION__);
    NSLog(@"warning! 不应该跑到这个方法:%@ %s，需要在对应的category中覆盖!", [self class], __FUNCTION__);
    return @"";
}

- (NSString *)channelSN
{
    NSLog(@"warning! 不应该跑到这个方法:%@ %s，需要在对应的category中覆盖!", [self class], __FUNCTION__);
    NSLog(@"warning! 不应该跑到这个方法:%@ %s，需要在对应的category中覆盖!", [self class], __FUNCTION__);
    NSLog(@"warning! 不应该跑到这个方法:%@ %s，需要在对应的category中覆盖!", [self class], __FUNCTION__);
    NSLog(@"warning! 不应该跑到这个方法:%@ %s，需要在对应的category中覆盖!", [self class], __FUNCTION__);
    NSLog(@"warning! 不应该跑到这个方法:%@ %s，需要在对应的category中覆盖!", [self class], __FUNCTION__);
    NSLog(@"warning! 不应该跑到这个方法:%@ %s，需要在对应的category中覆盖!", [self class], __FUNCTION__);
    NSLog(@"warning! 不应该跑到这个方法:%@ %s，需要在对应的category中覆盖!", [self class], __FUNCTION__);
    NSLog(@"warning! 不应该跑到这个方法:%@ %s，需要在对应的category中覆盖!", [self class], __FUNCTION__);
    NSLog(@"warning! 不应该跑到这个方法:%@ %s，需要在对应的category中覆盖!", [self class], __FUNCTION__);
    NSLog(@"warning! 不应该跑到这个方法:%@ %s，需要在对应的category中覆盖!", [self class], __FUNCTION__);
    return @"";
}

- (NSString *)UDIDName
{
    NSLog(@"warning! 不应该跑到这个方法:%@ %s，需要在对应的category中覆盖!", [self class], __FUNCTION__);
    NSLog(@"warning! 不应该跑到这个方法:%@ %s，需要在对应的category中覆盖!", [self class], __FUNCTION__);
    NSLog(@"warning! 不应该跑到这个方法:%@ %s，需要在对应的category中覆盖!", [self class], __FUNCTION__);
    NSLog(@"warning! 不应该跑到这个方法:%@ %s，需要在对应的category中覆盖!", [self class], __FUNCTION__);
    NSLog(@"warning! 不应该跑到这个方法:%@ %s，需要在对应的category中覆盖!", [self class], __FUNCTION__);
    NSLog(@"warning! 不应该跑到这个方法:%@ %s，需要在对应的category中覆盖!", [self class], __FUNCTION__);
    NSLog(@"warning! 不应该跑到这个方法:%@ %s，需要在对应的category中覆盖!", [self class], __FUNCTION__);
    NSLog(@"warning! 不应该跑到这个方法:%@ %s，需要在对应的category中覆盖!", [self class], __FUNCTION__);
    NSLog(@"warning! 不应该跑到这个方法:%@ %s，需要在对应的category中覆盖!", [self class], __FUNCTION__);
    NSLog(@"warning! 不应该跑到这个方法:%@ %s，需要在对应的category中覆盖!", [self class], __FUNCTION__);
    return @"";
}

- (NSString *)keychainServiceName
{
    NSLog(@"warning! 不应该跑到这个方法:%@ %s，需要在对应的category中覆盖!", [self class], __FUNCTION__);
    NSLog(@"warning! 不应该跑到这个方法:%@ %s，需要在对应的category中覆盖!", [self class], __FUNCTION__);
    NSLog(@"warning! 不应该跑到这个方法:%@ %s，需要在对应的category中覆盖!", [self class], __FUNCTION__);
    NSLog(@"warning! 不应该跑到这个方法:%@ %s，需要在对应的category中覆盖!", [self class], __FUNCTION__);
    NSLog(@"warning! 不应该跑到这个方法:%@ %s，需要在对应的category中覆盖!", [self class], __FUNCTION__);
    NSLog(@"warning! 不应该跑到这个方法:%@ %s，需要在对应的category中覆盖!", [self class], __FUNCTION__);
    NSLog(@"warning! 不应该跑到这个方法:%@ %s，需要在对应的category中覆盖!", [self class], __FUNCTION__);
    NSLog(@"warning! 不应该跑到这个方法:%@ %s，需要在对应的category中覆盖!", [self class], __FUNCTION__);
    NSLog(@"warning! 不应该跑到这个方法:%@ %s，需要在对应的category中覆盖!", [self class], __FUNCTION__);
    NSLog(@"warning! 不应该跑到这个方法:%@ %s，需要在对应的category中覆盖!", [self class], __FUNCTION__);
    return @"";
}

#pragma mark - 用户信息
- (void)updateUserInfo:(NSDictionary *)userInfo
{
    self.userInfo = userInfo;

    [[NSUserDefaults standardUserDefaults] setObject:self.userInfo forKey:kCTAppContextUserDefaultKeyUserInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)cleanUserInfo
{
    self.userInfo = nil;

    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCTAppContextUserDefaultKeyUserInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSDictionary *)userInfo
{
    if (_userInfo == nil) {
        _userInfo = [[NSUserDefaults standardUserDefaults] dictionaryForKey:kCTAppContextUserDefaultKeyUserInfo];
    }
    if (_userInfo == nil) {
        _userInfo = @{};
    }
    return _userInfo;
}

@end
