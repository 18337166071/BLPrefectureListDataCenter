//
//  BLPrefectureListtDataCenter.h
//  BLPrefectureListDataCenter
//
//  Created by 杨帅猛 on 2017/12/7.
//  Copyright © 2017年 杨帅猛. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const BLPrefectureDataCenterDateKeyGoodsId;
extern NSString * const BLPrefectureDataCenterDateKeyIsAvailable;
extern NSString * const BLPrefectureDataCenterDateKeyMarketPrice;
extern NSString * const BLPrefectureDataCenterDateKeyGoodsPrice;
extern NSString * const BLPrefectureDataCenterDateKeyGoodsMsg;
extern NSString * const BLPrefectureDataCenterDateKeyGoodsImgPath;
extern NSString * const BLPrefectureDataCenterDateKeyComSid;
extern NSString * const BLPrefectureDataCenterDateKeyCategoryid;
extern NSString * const BLPrefectureDataCenterDateKeyGoodsType;
extern NSString * const BLPrefectureDataCenterDateKeyActivityType;
extern NSString * const BLPrefectureDataCenterDateKeyYunType;
extern NSString * const BLPrefectureDataCenterDateKeyInfoStoreSid;
extern NSString * const BLPrefectureDataCenterDateKeySupplierSid;
extern NSString * const BLPrefectureDataCenterDateKeyGoodsNum;
extern NSString * const BLPrefectureDataCenterDateKeyGoodRatio;
extern NSString * const BLPrefectureDataCenterDateKeyIsMultiTypeBind;
extern NSString * const BLPrefectureDataCenterDateKeyMarkFlag;
extern NSString * const BLPrefectureDataCenterDateKeyHotPropValues;
extern NSString * const BLPrefectureDataCenterDateKeyBrandSid;

extern NSString * const BLPrefectureDataCenterDateKeyPrefectureId;
extern NSString * const BLPrefectureDataCenterDateKeyPrefectureName;

@interface BLPrefectureListDataCenter : NSObject

@property(nonatomic, copy) NSDictionary *prefectureData;

- (instancetype)initWithPrefectureId:(NSString *)prefectureId;

- (NSArray <NSDictionary *>*)fetchAllPrefectures;

- (NSArray <NSDictionary *>*)fetchPrefectureGoodsWithPrefectureId:(NSString *)prefectureId;

- (NSInteger)allGoodsCountAtPrefectureOfPrefectureId:(NSString *)prefectureId;

- (NSInteger)goodsCountWithGoodsId:(NSString *)goodsId atPrefectureId:(NSString *)prefectureId;

- (void)increaseGoodsNumberWithGoodsId:(NSString *)goodsId;

- (void)increaseGoodsNumberWithGoodsData:(NSDictionary *)goodsData;

- (void)reduceGoodsNumberWithGoodsId:(NSString *)goodsId;

- (void)insertGoodsWithPrefectureId:(NSString *)prefectureId goodsList:(NSArray *)goodsList;

- (void)deteteGoodsWithGoodsId:(NSString *)goodsId;

- (void)deletePrefectureWithPrefectureId:(NSString *)prefectureId;

@end
