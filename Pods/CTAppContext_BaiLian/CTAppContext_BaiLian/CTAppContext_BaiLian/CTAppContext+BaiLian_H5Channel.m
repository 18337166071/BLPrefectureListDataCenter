//
//  CTAppContext+BaiLian_H5Channel.m
//  CTAppContext_BaiLian
//
//  Created by user on 2017/9/13.
//  Copyright © 2017年 casa. All rights reserved.
//

#import "CTAppContext+BaiLian_H5Channel.h"
#import <objc/runtime.h>

static void * kCTAppContext_BaiLian_H5Channel_cm_mmcKey = &kCTAppContext_BaiLian_H5Channel_cm_mmcKey;
static void * kCTAppContext_BaiLian_H5Channel_methodKey = &kCTAppContext_BaiLian_H5Channel_methodKey;
static void * kCTAppContext_BaiLian_H5Channel_adverChannelKey = &kCTAppContext_BaiLian_H5Channel_adverChannelKey;
static void * kCTAppContext_BaiLian_H5Channel_batch_idKey = &kCTAppContext_BaiLian_H5Channel_batch_idKey;
static void * kCTAppContext_BaiLian_H5Channel_buidKey = &kCTAppContext_BaiLian_H5Channel_buidKey;
static void * kCTAppContext_BaiLian_H5Channel_store_idKey = &kCTAppContext_BaiLian_H5Channel_store_idKey;


@implementation CTAppContext (BaiLian_H5Channel)

- (void)setCm_mmc:(NSString *)cm_mmc
{
    objc_setAssociatedObject(self, kCTAppContext_BaiLian_H5Channel_cm_mmcKey, cm_mmc, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)cm_mmc
{
    return objc_getAssociatedObject(self, kCTAppContext_BaiLian_H5Channel_cm_mmcKey);
}

- (void)setMethod:(NSString *)method
{
    objc_setAssociatedObject(self, kCTAppContext_BaiLian_H5Channel_methodKey, method, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)method
{
    return objc_getAssociatedObject(self, kCTAppContext_BaiLian_H5Channel_methodKey);
}

- (void)setAdverChannel:(NSString *)adverChannel
{
    objc_setAssociatedObject(self, kCTAppContext_BaiLian_H5Channel_adverChannelKey, adverChannel, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)adverChannel
{
    return objc_getAssociatedObject(self, kCTAppContext_BaiLian_H5Channel_adverChannelKey);

}

- (void)setBatch_id:(NSString *)batch_id
{
    objc_setAssociatedObject(self, kCTAppContext_BaiLian_H5Channel_batch_idKey, batch_id, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)batch_id
{
    return objc_getAssociatedObject(self, kCTAppContext_BaiLian_H5Channel_batch_idKey);
}

- (void)setBuid:(NSString *)buid
{
    objc_setAssociatedObject(self, kCTAppContext_BaiLian_H5Channel_buidKey, buid, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)buid
{
    return objc_getAssociatedObject(self, kCTAppContext_BaiLian_H5Channel_buidKey);
}

- (void)setStore_id:(NSString *)store_id
{
    objc_setAssociatedObject(self, kCTAppContext_BaiLian_H5Channel_store_idKey, store_id, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)store_id
{
    return objc_getAssociatedObject(self, kCTAppContext_BaiLian_H5Channel_store_idKey);
}

@end
