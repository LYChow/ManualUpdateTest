//
//  HttpClient.m
//  ManualUpdateTest
//
//  Created by LY'S MacBook Air on 10/16/15.
//  Copyright © 2015 LY'S MacBook Air. All rights reserved.
//

#import "HttpClient.h"
#import "AFNetworking.h"

@implementation HttpResponse


@end

@implementation HttpClient



+(void)getRequestWithUrl:(NSString *)url  Parametes:(NSMutableDictionary *)params requestSuccess:(RequestSuccess)resquestSuccess requestFailue:(RequestFailue)requestFailue  requestTimeout:(float)timeout isEncryption:(BOOL)isEncryption
{

}

+(void)postRequestWithUrl:(NSString *)url  Parametes:(NSMutableDictionary *)params requestSuccess:(RequestSuccess)resquestSuccess requestFailue:(RequestFailue)requestFailue  requestTimeout:(float)timeout isEncryption:(BOOL)isEncryption
{
    //是否需要Token
    
    //进行签名加密
    
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    manager.requestSerializer =[AFJSONRequestSerializer serializer];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    
    #warning 设置服务器请求超时的时间
    
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        resquestSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        requestFailue(error);
    }];
}



@end
