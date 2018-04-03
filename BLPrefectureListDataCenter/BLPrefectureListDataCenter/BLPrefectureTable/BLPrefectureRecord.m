//
//  BLPrefectureRecord.m
//  BLPrefectureListDataCenter
//
//  Created by 杨帅猛 on 2017/12/8.
//  Copyright © 2017年 杨帅猛. All rights reserved.
//

#import "BLPrefectureRecord.h"
extern NSString * const BLPrefectureDataCenterDateKeyPrefectureId;
extern NSString * const BLPrefectureDataCenterDateKeyPrefectureName;

@implementation BLPrefectureRecord

#pragma mark - life cycles
- (instancetype)initWithData:(NSDictionary *)data
{
    if (self = [super init]) {
        self.prefectureId = data[BLPrefectureDataCenterDateKeyPrefectureId];
        self.prefectureName = data[BLPrefectureDataCenterDateKeyPrefectureName];
    }
    return self;
}

#pragma mark - CTPersistanceRecordProtocol
- (NSArray *)availableKeyList
{
    return @[@"primaryKey",@"prefectureId", @"memberId",@"prefectureName",@"expire"];
}

@end
