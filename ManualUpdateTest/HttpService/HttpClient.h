//
//  HttpClient.h
//  ManualUpdateTest
//
//  Created by LY'S MacBook Air on 10/16/15.
//  Copyright © 2015 LY'S MacBook Air. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpResponse : NSObject
/**
 *  把标示请求的Tag值和回调的data一起存在HttpResponse对象中
 */
@property(nonatomic,assign) NSUInteger httpTag;
/**
 *  接口请求返回对象
 */
@property(nonatomic,strong) id responseObject;

/**
 *  请求失败时返回的错误信息
 */
@property(nonatomic,strong) NSError *error;

@end


typedef void(^RequestSuccess) (id sucessResponse);
typedef void(^RequestFailue)  (NSError *error);

@interface HttpClient : NSObject

/**
 *  发送一个GET请求
 *
 *  @param url             请求接口
 *  @param params          请求的参数
 *  @param resquestSuccess 数据请求成功的回调
 *  @param requestFailue   数据请求失败的回调
 *  @param timeout         请求超时参数
 *  @param isEncryption    请求是否需要对请求参数进行签名、加密
 */
+(void)getRequestWithUrl:(NSString *)url  Parametes:(NSMutableDictionary *)params requestSuccess:(RequestSuccess)resquestSuccess requestFailue:(RequestFailue)requestFailue  requestTimeout:(float)timeout isEncryption:(BOOL)isEncryption;


/**
 *  发送一个POST请求
 *
 *  @param url             请求接口
 *  @param params          请求的参数
 *  @param resquestSuccess 数据请求成功的回调
 *  @param requestFailue   数据请求失败的回调
 *  @param timeout         请求超时参数
 *  @param isEncryption    请求是否需要对请求参数进行签名、加密
 */
+(void)postRequestWithUrl:(NSString *)url  Parametes:(NSMutableDictionary *)params requestSuccess:(RequestSuccess)resquestSuccess requestFailue:(RequestFailue)requestFailue  requestTimeout:(float)timeout isEncryption:(BOOL)isEncryption;

@end
