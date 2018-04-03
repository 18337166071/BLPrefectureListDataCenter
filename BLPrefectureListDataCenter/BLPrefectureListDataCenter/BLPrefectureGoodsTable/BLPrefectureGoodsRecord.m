//
//  BLPrefectureGoodsRecord.m
//  BLPrefectureListDataCenter
//
//  Created by 杨帅猛 on 2017/12/8.
//  Copyright © 2017年 杨帅猛. All rights reserved.
//

#import "BLPrefectureGoodsRecord.h"
#import <BLSafeFetchDataFunctions/BLSafeFetchDataFunctions.h>

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


@implementation BLPrefectureGoodsRecord

#pragma mark - life cycles
- (instancetype)initWithGoodsData:(NSDictionary *)goodsData
{
    self = [super init];
    if (self) {
        self.goodsId = goodsData[BLPrefectureDataCenterDateKeyGoodsId];
        //商品详情页只有一个价格，防止获取不到价格
        if (stringFromObject(goodsData, BLPrefectureDataCenterDateKeyMarketPrice).length == 0 && stringFromObject(goodsData, BLPrefectureDataCenterDateKeyGoodsPrice).length > 0) {
            self.marketPrice = goodsData[BLPrefectureDataCenterDateKeyGoodsPrice];
        }else{
            self.marketPrice = goodsData[BLPrefectureDataCenterDateKeyMarketPrice];
        }
        if (stringFromObject(goodsData, BLPrefectureDataCenterDateKeyMarketPrice).length > 0 && stringFromObject(goodsData, BLPrefectureDataCenterDateKeyGoodsPrice).length == 0) {
            self.goodsPrice = goodsData[BLPrefectureDataCenterDateKeyMarketPrice];
        }else{
            self.goodsPrice = goodsData[BLPrefectureDataCenterDateKeyGoodsPrice];
        }
        self.isAvailable = goodsData[BLPrefectureDataCenterDateKeyIsAvailable];
        self.goodsMsg = goodsData[BLPrefectureDataCenterDateKeyGoodsMsg];
        self.categoryid = goodsData[BLPrefectureDataCenterDateKeyCategoryid];
        self.goodsType = goodsData[BLPrefectureDataCenterDateKeyGoodsType];
        self.goodsImgPath = goodsData[BLPrefectureDataCenterDateKeyGoodsImgPath];
        self.brandSid = goodsData[BLPrefectureDataCenterDateKeyBrandSid];
        self.comSid = goodsData[BLPrefectureDataCenterDateKeyComSid];
        self.goodsType = goodsData[BLPrefectureDataCenterDateKeyGoodsType];
        self.activityType = goodsData[BLPrefectureDataCenterDateKeyActivityType];
        self.yunType = goodsData[BLPrefectureDataCenterDateKeyYunType];
        self.infoStoreSid = goodsData[BLPrefectureDataCenterDateKeyInfoStoreSid];
        self.supplierSid = goodsData[BLPrefectureDataCenterDateKeySupplierSid];
        self.goodRatio = goodsData[BLPrefectureDataCenterDateKeyGoodRatio];
        self.isMultiTypeBind = goodsData[BLPrefectureDataCenterDateKeyIsMultiTypeBind];
        self.markFlag = goodsData[BLPrefectureDataCenterDateKeyMarkFlag];
        self.hotPropValues = goodsData[BLPrefectureDataCenterDateKeyHotPropValues];
        self.goodsNum = goodsData[BLPrefectureDataCenterDateKeyGoodsNum];
    }
    return self;
}
#pragma mark - CTPersistanceRecordProtocol
- (NSArray *)availableKeyList
{
    return @[@"primaryKey",@"isAvailable",@"goodsId", @"marketPrice", @"goodsPrice",@"goodsMsg",@"goodsImgPath",@"brandSid",@"comSid",@"categoryid",@"goodsType",@"activityType",@"yunType",@"infoStoreSid",@"supplierSid",@"goodsNum",@"goodsNumber",@"goodRatio",@"isMultiTypeBind",@"markFlag",@"hotPropValues",@"prefectureId",@"memberId"];
}

@end
