
//  Created by Seraphism on 13-12-2.
//  Copyright (c) 2014年 Thinkland. All rights reserved.
//

#import <Foundation/Foundation.h>

/* 条码数据服务类 */
@interface Barcode : NSObject

/**
  @discuss 初始化方法, 仅供SDK内部调用, 开发者调用, 返回nil
 */
- (instancetype)initWithCodeURL:(NSString *)urlstring;

/**
  执行条码数据请求, 操作请求返回的数据
  @param api           条码数据服务类型
  @param httpMethod    HTTP请求方法
  @param paras         对应于服务类型的一些参数, 是Objective-C类型
  @param success       请求得到处理, 并且返回有效数据时, 对返回的数据, 在主线程, 执行自定义的行为
  @param failure       没有网络, 或者服务器没有响应, 或者服务器没有返回有效数据, 对返回的NSError对象, 在主线程, 执行自定义的行为
  @discuss             a. 数据服务类型的选择, 对应可用的HTTP请求方法, 对应可用的请求参数, 执行请求返回的Objective-C对象, 请参考电商数据SDK文档
                       b. 执行数据请求是异步的, 开发者直接调用即可.
 */
- (void)executeWorkWithAPI:(NSString *)api method:(NSString *)httpMethod parameters:(NSDictionary *)paras success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failre;

@end
