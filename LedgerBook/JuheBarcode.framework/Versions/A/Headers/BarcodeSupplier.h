
//  Created by Seraphism on 14-1-13.
//  Copyright (c) 2014年 Thinkland. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Barcode;
@class JuheClient;

/* 数据服务管理类 */
@interface BarcodeSupplier : NSObject

/**
 @return 数据服务管理类的一个共享实例
 */
+ (instancetype)sharedSupplier;

- (JuheClient *)serviceClient;

#pragma mark - 条码数据服务
/**
 注册条码数据服务所需要的key
 @param keyString  申请的有效key
 @discuss          a. key通过聚合官网申请, key的相关说明参考官网
 b. 可以多次register, 最后register的key最先获取
 */
- (void)registerBarcodeKey:(NSString *)keyString;

/**
 注销条码数据服务所需要的key
 @param keyString  申请的有效key
 @dicuss           a. key通过聚合官网申请
 b. 没有电商数据服务所需要的key, 将无法获得电商数据服务
 */
- (void)unregisterBarcodeKey:(NSString *)keyString;

/**
 获取最后注册的电商数据服务所需要的key
 @discuss          没有注册，或者取消所有注册的条码数据服务的key, 返回nil
 */
- (NSString *)getLatestBarcodeKey;

/**
 获取条码数据服务
 @discuss          在注册了条码数据服务的key的条件下, 返回有效的对象
 */
- (Barcode *)getBarcodeService;

@end
