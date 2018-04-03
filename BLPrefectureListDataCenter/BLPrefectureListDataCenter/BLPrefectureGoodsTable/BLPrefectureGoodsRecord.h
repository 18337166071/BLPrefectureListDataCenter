//
//  BLPrefectureGoodsRecord.h
//  BLPrefectureListDataCenter
//
//  Created by 杨帅猛 on 2017/12/8.
//  Copyright © 2017年 杨帅猛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CTPersistance/CTPersistanceRecord.h>

@interface BLPrefectureGoodsRecord : CTPersistanceRecord

@property (nonatomic, strong) NSNumber *primaryKey;
@property (nonatomic, copy) NSString *goodsId;
@property (nonatomic, copy) NSString *isAvailable;
@property (nonatomic, copy) NSString *marketPrice;
@property (nonatomic, copy) NSString *goodsPrice;
@property (nonatomic, copy) NSString *goodsMsg;
@property (nonatomic, copy) NSString *goodsImgPath;

@property (nonatomic, copy) NSString *brandSid;
@property (nonatomic, copy) NSString *comSid;
@property (nonatomic, copy) NSString *categoryid;
@property (nonatomic, copy) NSString *goodsType;
@property (nonatomic, copy) NSString *activityType;
@property (nonatomic, copy) NSString *yunType;
@property (nonatomic, copy) NSString *infoStoreSid;
@property (nonatomic, copy) NSString *supplierSid;
@property (nonatomic, copy) NSString *goodRatio;
@property (nonatomic, copy) NSString *isMultiTypeBind;
@property (nonatomic, copy) NSString *markFlag;
@property (nonatomic, copy) NSString *hotPropValues;
@property (nonatomic, strong)NSNumber * goodsNum;//搜索返回的
@property (nonatomic, strong)NSNumber * goodsNumber;//本地存的

@property (nonatomic, copy) NSString *prefectureId;
@property (nonatomic, copy) NSString *memberId;

- (instancetype)initWithGoodsData:(NSDictionary *)goodsData;

@end
