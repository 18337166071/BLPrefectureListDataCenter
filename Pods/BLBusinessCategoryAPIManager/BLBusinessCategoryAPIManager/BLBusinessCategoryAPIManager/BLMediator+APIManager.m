//
//  BLMediator+APIManager.m
//  BLBusinessCategoryAPIManager
//
//  Created by casa on 2016/12/19.
//  Copyright © 2016年 casa. All rights reserved.
//

#import "BLMediator+APIManager.h"

NSString * const kBLMediatorTargetAPIManager = @"APIManager";

@implementation BLMediator (APIManager)

- (void)loadAPIDownGradeInfo:(void (^)(NSDictionary *))successCallback
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"successCallback"] = successCallback;
    [self performTarget:kBLMediatorTargetAPIManager action:@"loadAPIDownGradeInfo" params:params shouldCacheTarget:YES];
}

- (void)loadModuleDownGradeInfo:(void (^)(NSDictionary *))successCallback
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"successCallback"] = successCallback;
    [self performTarget:kBLMediatorTargetAPIManager action:@"loadModuleDownGradeInfo" params:params shouldCacheTarget:YES];
}

@end
