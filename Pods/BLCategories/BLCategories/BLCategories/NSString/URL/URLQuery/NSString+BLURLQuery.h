//
//  NSString+BLURLQuery.h
//  BLCategories
//
//  Created by casa on 2017/3/22.
//  Copyright © 2017年 casa. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kCTJSBridgeParamKeyCallbackIdentifier;
extern NSString * const kCTJSBridgeParamKeyParams;
extern NSString * const kCTJSBridgeParamKeyTargetName;
extern NSString * const kCTJSBridgeParamKeyActionName;

@interface NSString (BLURLQuery)

- (NSDictionary *)URLQuery_dictionary;

- (NSDictionary *)BL_queryDictonary;

@end
