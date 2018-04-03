//
//  BLPrefectureListtDataCenter.m
//  BLPrefectureListDataCenter
//
//  Created by 杨帅猛 on 2017/12/7.
//  Copyright © 2017年 杨帅猛. All rights reserved.
//

#import "BLPrefectureListDataCenter.h"
#import <UIKit/UIKit.h>
#import <CTAppContext_BaiLian/CTAppContext+BaiLian.h>
#import <BLSafeFetchDataFunctions/BLSafeFetchDataFunctions.h>
#import "BLPrefectureGoodsTable.h"
#import "BLPrefectureGoodsRecord.h"
#import "BLPrefectureTable.h"
#import "BLPrefectureRecord.h"

NSString * const BLPrefectureDataCenterDateKeyGoodsId = @"BLPrefectureDataCenterDateKeyGoodsId";
NSString * const BLPrefectureDataCenterDateKeyIsAvailable = @"BLPrefectureDataCenterDateKeyIsAvailable";
NSString * const BLPrefectureDataCenterDateKeyMarketPrice = @"BLPrefectureDataCenterDateKeyMarketPrice";
NSString * const BLPrefectureDataCenterDateKeyGoodsPrice = @"BLPrefectureDataCenterDateKeyGoodsPrice";
NSString * const BLPrefectureDataCenterDateKeyGoodsMsg = @"BLPrefectureDataCenterDateKeyGoodsMsg";
NSString * const BLPrefectureDataCenterDateKeyGoodsImgPath = @"BLPrefectureDataCenterDateKeyGoodsImgPath";
NSString * const BLPrefectureDataCenterDateKeyComSid = @"BLPrefectureDataCenterDateKeyComSid";
NSString * const BLPrefectureDataCenterDateKeyCategoryid = @"BLPrefectureDataCenterDateKeyCategoryid";
NSString * const BLPrefectureDataCenterDateKeyGoodsType = @"BLPrefectureDataCenterDateKeyGoodsType";
NSString * const BLPrefectureDataCenterDateKeyActivityType = @"BLPrefectureDataCenterDateKeyActivityType";
NSString * const BLPrefectureDataCenterDateKeyYunType = @"BLPrefectureDataCenterDateKeyYunType";
NSString * const BLPrefectureDataCenterDateKeyInfoStoreSid = @"BLPrefectureDataCenterDateKeyInfoStoreSid";
NSString * const BLPrefectureDataCenterDateKeySupplierSid = @"BLPrefectureDataCenterDateKeySupplierSid";
NSString * const BLPrefectureDataCenterDateKeyGoodsNum = @"BLPrefectureDataCenterDateKeyGoodsNum";//搜索返回的
NSString * const BLPrefectureDataCenterDateKeyGoodsNumber = @"BLPrefectureDataCenterDateKeyGoodsNumber";//本地存的
NSString * const BLPrefectureDataCenterDateKeyGoodRatio = @"BLPrefectureDataCenterDateKeyGoodRatio";
NSString * const BLPrefectureDataCenterDateKeyIsMultiTypeBind = @"BLPrefectureDataCenterDateKeyIsMultiTypeBind";
NSString * const BLPrefectureDataCenterDateKeyMarkFlag = @"BLPrefectureDataCenterDateKeyMarkFlag";
NSString * const BLPrefectureDataCenterDateKeyHotPropValues = @"BLPrefectureDataCenterDateKeyHotPropValues";
NSString * const BLPrefectureDataCenterDateKeyBrandSid = @"BLPrefectureDataCenterDateKeyBrandSid";

NSString * const BLPrefectureDataCenterDateKeyPrefectureId = @"BLPrefectureDataCenterDateKeyPrefectureId";
NSString * const BLPrefectureDataCenterDateKeyPrefectureName = @"BLPrefectureDataCenterDateKeyPrefectureName";

CGFloat const BLPrefectureExpire = 259200; //3天有效期

@interface BLPrefectureListDataCenter ()

@property (nonatomic, strong) BLPrefectureTable * prefectureTable;

@property (nonatomic, strong) BLPrefectureGoodsTable *prefectureGoodsTable;

@property (nonatomic, copy) NSString *prefectureId;
@end

@implementation BLPrefectureListDataCenter

#pragma mark - life cycles
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self validateExpire];
    }
    return self;
}

- (instancetype)initWithPrefectureId:(NSString *)prefectureId
{
    self = [super init];
    if (self) {
        _prefectureId = prefectureId;
        [self validateExpire];
    }
    return self;
}

#pragma mark - Public Methods

- (NSArray *)fetchAllPrefectures
{
    if (isEmptyString([CTAppContext sharedInstance].memberId)) {
        return nil; //没有登录直接return掉
    }
    NSString *whereCondition = [NSString stringWithFormat:@"memberId = %@ order by expire desc",self.memberId];
    NSArray *fetchPrefectureList = [self.prefectureTable findAllWithWhereCondition:whereCondition conditionParams:nil isDistinct:NO error:nil];
    
    NSMutableArray *prefectureItemList = [[NSMutableArray alloc] init];
    NSInteger maxCount = fetchPrefectureList.count > 2 ? 2 : fetchPrefectureList.count;
    for (NSInteger index = 0; index < maxCount; index++) {
        BLPrefectureRecord *prefectureRecord = fetchPrefectureList[index];
        NSArray *fetchGoodsList = [self fetchAllGoodsWithPrefectureId:prefectureRecord.prefectureId];
        if (fetchGoodsList.count >0) {
            [prefectureItemList addObject:[prefectureRecord dictionaryRepresentationWithTable:self.prefectureTable]];
        }
    }
    return prefectureItemList;
}

- (NSArray *)fetchPrefectureGoodsWithPrefectureId:(NSString *)prefectureId
{
    if (isEmptyString([CTAppContext sharedInstance].memberId)) {
        return nil; //没有登录直接return掉
    }
    NSArray *fetchGoodsList = [self fetchAllGoodsWithPrefectureId:prefectureId];
    NSMutableArray *goodsItemList = [[NSMutableArray alloc] init];
    [fetchGoodsList enumerateObjectsUsingBlock:^(BLPrefectureGoodsRecord *  _Nonnull prefectureRecord, NSUInteger idx, BOOL * _Nonnull stop) {
        [goodsItemList addObject:[prefectureRecord dictionaryRepresentationWithTable:self.prefectureGoodsTable]];
    }];
    return goodsItemList;
}

- (NSInteger)allGoodsCountAtPrefectureOfPrefectureId:(NSString *)prefectureId
{
    if (![self isLogOn]) {
        return 0;
    }
    NSArray *goodsList = [self fetchAllGoodsWithPrefectureId:prefectureId];
    __block NSInteger goodsCount = 0;
    [goodsList enumerateObjectsUsingBlock:^(BLPrefectureGoodsRecord *  _Nonnull prefectureRecord, NSUInteger idx, BOOL * _Nonnull stop) {
        goodsCount += [prefectureRecord.goodsNumber intValue];
    }];
    return goodsCount;
}

- (NSInteger)goodsCountWithGoodsId:(NSString *)goodsId atPrefectureId:(NSString *)prefectureId
{
    if (![self isLogOn]) {
        return 0;
    }
    NSArray *goodsList = [self fetchGoodsWithPrefectureId:prefectureId goodsId:goodsId];
    __block NSInteger goodsCount = 0;
    [goodsList enumerateObjectsUsingBlock:^(BLPrefectureGoodsRecord *  _Nonnull prefectureRecord, NSUInteger idx, BOOL * _Nonnull stop) {
        goodsCount += [prefectureRecord.goodsNumber intValue];
    }];
    return goodsCount;
}


- (void)increaseGoodsNumberWithGoodsId:(NSString *)goodsId
{
    if ([self isLogOn]) {
        [self updateGoodsNumberWithGoodsList:[self fetchGoodsAtCuttentPrefectureWithGoodsId:goodsId]];
    }
}

- (void)increaseGoodsNumberWithGoodsData:(NSDictionary *)goodsData
{
    NSArray * localPrefectures = [self fetchCurrentPrefecture];
    if (localPrefectures.count) {
        [self updateGoodsNumberWhenIncreaseWithGoodsData:goodsData];
        [self updatePrefectureExpireWithPrefectureRecord:localPrefectures[0]];
    }else{
        [self insertPrefectureWithPrefectureId:self.prefectureId];
        [self insertGoodsAtCurrentPrefectureWithGoodsData:goodsData];
    }
}

- (void)reduceGoodsNumberWithGoodsId:(NSString *)goodsId
{
    NSArray *fetchGoodsList = [self fetchGoodsAtCuttentPrefectureWithGoodsId:goodsId];
    if (fetchGoodsList.count > 0) {
        BLPrefectureGoodsRecord * goodsRecord = fetchGoodsList[0];
        if ([goodsRecord.goodsNumber intValue]  == 1) {
            [self.prefectureGoodsTable deleteRecord:goodsRecord error:nil];
            NSArray *allFetchGoodsList = [self fetchAllGoodsWithPrefectureId:self.prefectureId];
            if (allFetchGoodsList.count == 0) {
                [self deletePrefectureWithPrefectureId:self.prefectureId];
            }
        }else{
            NSInteger goodsNumber = [goodsRecord.goodsNumber intValue]  - 1;
            goodsRecord.goodsNumber = [NSNumber numberWithInteger:goodsNumber];
            [self.prefectureGoodsTable updateRecord:goodsRecord error:nil];
        }
        NSArray * localPrefectures = [self fetchCurrentPrefecture];
        if(localPrefectures.count){
            [self updatePrefectureExpireWithPrefectureRecord:localPrefectures[0]];
        }
    }
}

- (void)insertGoodsWithPrefectureId:(NSString *)prefectureId goodsList:(NSArray *)goodsList
{
    
    if (isEmptyString(prefectureId) || goodsList.count == 0) {
        return;
    }
    //清除当前专区
    NSArray *localPrefectures = [self fetchPrefectureWithPrefectureId:prefectureId];
    if (localPrefectures.count) {
        [self deletePrefectureWithPrefectureId:prefectureId];
    }
    //1.插入专区 2.插入专区商品
    [self insertPrefectureWithPrefectureId:prefectureId];
    NSMutableArray *goodsRecordList = [[NSMutableArray alloc] init];
    [goodsList enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull goodsData, NSUInteger idx, BOOL * _Nonnull stop) {
        BLPrefectureGoodsRecord *goodsRecord = [[BLPrefectureGoodsRecord alloc] initWithGoodsData:goodsData];
        goodsRecord.goodsNumber = [NSNumber numberWithInteger:integerFromObject(goodsData, BLPrefectureDataCenterDateKeyGoodsNum)];
        goodsRecord.memberId = self.memberId;
        goodsRecord.prefectureId = prefectureId;
        [goodsRecordList addObject:goodsRecord];
    }];
    [self.prefectureGoodsTable insertRecordList:goodsRecordList error:nil];
}

- (void)deteteGoodsWithGoodsId:(NSString *)goodsId
{
    NSArray *fetchGoodsList = [self fetchGoodsAtCuttentPrefectureWithGoodsId:goodsId];
    [self.prefectureGoodsTable deleteRecordList:fetchGoodsList error:nil];
    NSArray *allFetchGoodsList = [self fetchAllGoodsWithPrefectureId:self.prefectureId];
    if (allFetchGoodsList.count == 0) {
        [self deletePrefectureWithPrefectureId:self.prefectureId];
    }
    NSArray * localPrefectures = [self fetchCurrentPrefecture];
    if(localPrefectures.count){
        [self updatePrefectureExpireWithPrefectureRecord:localPrefectures[0]];
    }
}

- (void)deletePrefectureWithPrefectureId:(NSString *)PrefectureId
{
    [self deleteAllGoodsWithPrefectureId:PrefectureId];
}
#pragma mark -  Private method
- (NSArray *)fetchCurrentPrefecture
{
    return [self fetchPrefectureWithPrefectureId:self.prefectureId];
}

- (NSArray *)fetchPrefectureWithPrefectureId:(NSString *)prefectureId
{
    NSString * wherePrefectureCondition = [NSString stringWithFormat:@"prefectureId = %@ and memberId = %@", prefectureId,self.memberId];
    return  [self.prefectureTable findAllWithWhereCondition:wherePrefectureCondition conditionParams:nil isDistinct:NO error:nil];
}

- (NSArray *)fetchGoodsAtCuttentPrefectureWithGoodsId:(NSString *)goodsId
{
    return [self fetchGoodsWithPrefectureId:self.prefectureId goodsId:goodsId];
}

- (NSArray *)fetchGoodsWithPrefectureId:(NSString *)prefectureId goodsId:(NSString *)goodsId
{
    NSString * whereGoodsCondition = [NSString stringWithFormat:@"prefectureId = %@ and goodsId = %@ and memberId = %@", prefectureId,goodsId,self.memberId];
    return [self.prefectureGoodsTable findAllWithWhereCondition:whereGoodsCondition conditionParams:nil isDistinct:NO error:nil];
}

- (NSArray *)fetchAllGoodsWithPrefectureId:(NSString *)prefectureId
{
    NSString *whereGoodsConfition = [NSString stringWithFormat:@"prefectureId = %@ and memberId = %@", prefectureId,self.memberId];
    return  [self.prefectureGoodsTable findAllWithWhereCondition:whereGoodsConfition conditionParams:nil isDistinct:NO error:nil];
}

- (void)insertGoodsAtCurrentPrefectureWithGoodsData:(NSDictionary *)goodsData
{
    [self insertGoodsWithGoodsData:goodsData atPrefecture:self.prefectureId];
}

- (void)insertGoodsWithGoodsData:(NSDictionary *)goodsData atPrefecture:(NSString *)prefectureId
{
    BLPrefectureGoodsRecord *goodsRecord = [[BLPrefectureGoodsRecord alloc] initWithGoodsData:goodsData];
    goodsRecord.prefectureId = prefectureId;
    goodsRecord.goodsNumber = [NSNumber numberWithInt:1];
    goodsRecord.memberId = self.memberId;
    [self.prefectureGoodsTable insertRecord:goodsRecord error:nil];
}

- (void)insertPrefectureWithPrefectureId:(NSString *)prefectureId
{
    BLPrefectureRecord * prefectureRecord = [[BLPrefectureRecord alloc] initWithData:self.prefectureData];
    prefectureRecord.prefectureId = prefectureId;
    prefectureRecord.memberId = self.memberId;
    prefectureRecord.expire = [NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970] + BLPrefectureExpire];
    [self.prefectureTable insertRecord:prefectureRecord error:nil];
    
    NSString *whereCondition = [NSString stringWithFormat:@"memberId = %@ order by expire desc",self.memberId];
    NSArray *fetchPrefectureList = [self.prefectureTable findAllWithWhereCondition:whereCondition conditionParams:nil isDistinct:NO error:nil];
    if (fetchPrefectureList.count > 2) {
        for (NSInteger index = 2; index < fetchPrefectureList.count ; index ++) {
            BLPrefectureRecord *prefectureRecord = fetchPrefectureList[index];
            if ([prefectureRecord.prefectureId isEqualToString:prefectureId]) {
                continue;
            }
            [self deletePrefectureWithPrefectureId:prefectureRecord.prefectureId];
        }
    }
}

- (void)updateGoodsNumberWhenIncreaseWithGoodsData:(NSDictionary *)goodsData
{
    NSArray * localGoodsList = [self fetchGoodsAtCuttentPrefectureWithGoodsId:goodsData[BLPrefectureDataCenterDateKeyGoodsId]];
    if (localGoodsList.count > 0) {
        [self updateGoodsNumberWithGoodsList:localGoodsList];
    }else{
        [self insertGoodsAtCurrentPrefectureWithGoodsData:goodsData];
    }
}

- (void)updateGoodsNumberWithGoodsList:(NSArray *)goodsList
{
    if (goodsList.count == 1) {
        BLPrefectureGoodsRecord *goodsRecord = goodsList[0];
        NSInteger goodsNumber = [goodsRecord.goodsNumber intValue] + 1;
        goodsRecord.goodsNumber = [NSNumber numberWithInteger:goodsNumber];
        [self.prefectureGoodsTable updateRecord:goodsRecord error:nil];
    }else{
        NSInteger totalCount = 0;
        for (NSInteger index = 1; index < goodsList.count; index++) {
            BLPrefectureGoodsRecord * record = goodsList[index];
            totalCount += [record.goodsNumber intValue];
            [self.prefectureGoodsTable deleteRecord:record error:nil];
        }
        BLPrefectureGoodsRecord * record = goodsList[0];
        NSInteger goodsNumber = [record.goodsNumber integerValue] + 1 + totalCount;
        record.goodsNumber = [NSNumber numberWithInteger:goodsNumber];
        [self.prefectureGoodsTable updateRecord:record error:nil];
    }
}

- (void)updatePrefectureExpireWithPrefectureRecord:(BLPrefectureRecord *)prefectureRecord
{
    prefectureRecord.expire = [NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970] + BLPrefectureExpire];
    [self.prefectureGoodsTable updateRecord:prefectureRecord error:nil];
}

- (void)deleteAllGoodsWithPrefectureId:(NSString *)prefectureId
{
    [self.prefectureGoodsTable deleteRecordList:[self fetchAllGoodsWithPrefectureId:prefectureId] error:nil];
}

- (void)validateExpire
{
    if (isEmptyString([CTAppContext sharedInstance].memberId)) {
        return; //没有登录直接return掉
    }
    NSString * whereCondition = [NSString stringWithFormat:@"memberId = %@",self.memberId];
    NSArray * fetchPrefectureList = [self.prefectureTable findAllWithWhereCondition:whereCondition conditionParams:nil isDistinct:NO error:nil];
    for (BLPrefectureRecord *prefectureRecord in fetchPrefectureList) {
        if ([prefectureRecord.expire doubleValue] <= [[NSDate date] timeIntervalSince1970] ){ //已经过期了
            [self deteteGoodsWithGoodsId:prefectureRecord.prefectureId];
        }
    }
}

#pragma mark - getters and setters

- (BLPrefectureTable *)prefectureTable
{
    if (_prefectureTable == nil) {
        _prefectureTable = [[BLPrefectureTable alloc] init];
    }
    return _prefectureTable;
}

- (BLPrefectureGoodsTable *)prefectureGoodsTable
{
    if (_prefectureGoodsTable == nil) {
        _prefectureGoodsTable = [[BLPrefectureGoodsTable alloc] init];
    }
    return _prefectureGoodsTable;
}

- (NSString *)memberId
{
    return isEmptyString([CTAppContext sharedInstance].memberId) ? @"1" : [CTAppContext sharedInstance].memberId;
}

- (BOOL)isLogOn
{
    return !isEmptyString([CTAppContext sharedInstance].memberId);
}

@end

