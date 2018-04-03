//
//  BLPrefectureGoodsTable.m
//  BLPrefectureListDataCenter
//
//  Created by 杨帅猛 on 2017/12/8.
//  Copyright © 2017年 杨帅猛. All rights reserved.
//

#import "BLPrefectureGoodsTable.h"
#import "BLPrefectureGoodsRecord.h"

@implementation BLPrefectureGoodsTable

#pragma mark - CTPersistanceTableProtocol
- (NSString *)tableName
{
    return @"BLPrefectureGoods";
}

- (NSString *)databaseName
{
    return @"blprefecturegoodsdatabase.sqlite";
}

- (NSDictionary *)columnInfo
{
    return @{
             @"primaryKey":@"INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL",
             @"isAvailable":@"TEXT",
             @"goodsId":@"TEXT",
             @"marketPrice":@"TEXT",
             @"goodsPrice":@"TEXT",
             @"goodsMsg":@"TEXT",
             @"goodsImgPath":@"TEXT",
             @"brandSid":@"TEXT",
             @"comSid" :@"TEXT",
             @"categoryid":@"TEXT",
             @"goodsType":@"TEXT",
             @"activityType":@"TEXT",
             @"yunType":@"TEXT",
             @"infoStoreSid":@"TEXT",
             @"supplierSid":@"TEXT",
             @"goodsNum":@"INTEGER",
             @"goodsNumber":@"INTEGER",
             @"goodRatio":@"TEXT",
             @"isMultiTypeBind":@"TEXT",
             @"markFlag":@"TEXT",
             @"hotPropValues":@"TEXT",
             @"prefectureId":@"TEXT",
             @"memberId":@"TEXT"
             };
}
- (Class)recordClass
{
    return [BLPrefectureGoodsRecord class];
}

- (NSString *)primaryKeyName
{
    return @"primaryKey";
}

- (void)modifyDatabaseName:(NSString *)databaseName
{
    
}


@end
