//
//  BLPrefectureRecord.h
//  BLPrefectureListDataCenter
//
//  Created by 杨帅猛 on 2017/12/8.
//  Copyright © 2017年 杨帅猛. All rights reserved.
//

#import <CTPersistance/CTPersistance.h>

@interface BLPrefectureRecord : CTPersistanceRecord

@property (nonatomic, strong) NSNumber *primaryKey;
@property (nonatomic, copy) NSString *prefectureId;
@property (nonatomic, copy) NSString *memberId;
@property (nonatomic, copy) NSString *prefectureName;
@property (nonatomic, strong) NSNumber * expire;

- (instancetype)initWithData:(NSDictionary *)data;

@end
