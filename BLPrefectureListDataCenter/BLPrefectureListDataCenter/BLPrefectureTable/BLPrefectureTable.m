//
//  BLPrefectureTable.m
//  BLPrefectureListDataCenter
//
//  Created by 杨帅猛 on 2017/12/8.
//  Copyright © 2017年 杨帅猛. All rights reserved.
//

#import "BLPrefectureTable.h"
#import "BLPrefectureRecord.h"

@implementation BLPrefectureTable

#pragma mark - CTPersistanceTableProtocol
- (NSString *)tableName
{
    return @"BLPrefecture";
}

- (NSString *)databaseName
{
    return @"blprefecturedatabase.sqlite";
}

- (NSDictionary *)columnInfo
{
    return @{
             @"primaryKey":@"INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL",
             @"prefectureId":@"TEXT",
             @"memberId":@"TEXT",
             @"prefectureName":@"TEXT",
             @"expire":@"INTEGER"
             };
}

- (Class)recordClass
{
    return [BLPrefectureRecord class];
}

- (NSString *)primaryKeyName
{
    return @"primaryKey";
}

- (void)modifyDatabaseName:(NSString *)databaseName
{
    
}

@end
