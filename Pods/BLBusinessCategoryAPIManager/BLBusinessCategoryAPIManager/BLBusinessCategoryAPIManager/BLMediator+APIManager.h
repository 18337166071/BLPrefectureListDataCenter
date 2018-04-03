//
//  BLMediator+APIManager.h
//  BLBusinessCategoryAPIManager
//
//  Created by casa on 2016/12/19.
//  Copyright © 2016年 casa. All rights reserved.
//

#import <BLMediator/BLMediator.h>
#import <UIKit/UIKit.h>

@interface BLMediator (APIManager)

- (void)loadAPIDownGradeInfo:(void(^)(NSDictionary *downGradeInfo))successCallback;
- (void)loadModuleDownGradeInfo:(void(^)(NSDictionary *downGradeInfo))successCallback;

@end
