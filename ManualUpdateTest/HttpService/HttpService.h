//
//  HttpService.h
//  ManualUpdateTest
//
//  Created by LY'S MacBook Air on 10/16/15.
//  Copyright © 2015 LY'S MacBook Air. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HttpClient.h"

#define BaseUrl                        @"http://pms.stage.yunshanmeicai.com/crm"
#define APP_GetSupplierGoods           @"/supplierPrice/getsuppliercontentandprice"

typedef enum : NSUInteger {
    NoneFailueType,
    AlertFailueType,
    ToastFailueType,
} FailueType;


@protocol HttpServiceDelegate <NSObject>

-(void)requestSuccess:(HttpResponse *)response;

-(void)requestFailue:(HttpResponse *)response;


@end

@interface HttpService : NSObject


/**
 *  服务器调用接口实例
 */
@property(nonatomic,strong) HttpService *currentService;


/**
 *  把请求的数据回调到控制器实现的Delegate方法中
 */
@property (nonatomic,weak) id <HttpServiceDelegate> delegate;

/**
 *  服务器响应了数据请求,但是返回的是错误信息
 */
@property (nonatomic,assign) BOOL isRequestSuccessError;
/**
 *  请求报价模块价格列表数据
 *
 *  @param sid       某个商品的id,传nil默认请求所有数据
 *  @param needToken 请求是否需要Token
 *  @param type      请求失败时,弹出提示的类型
 *
 *  @return 报价接口请求的唯一标示Tag
 */
-(NSUInteger)requestSupplierGoodsInfoBySid:(NSString *)sid isNeedToken:(BOOL)needToken andAlertType:(FailueType)failueType;

/**
 *  用户登陆请求
 *
 *  @param userName  用户名
 *  @param password  密码
 *  @param cityId    城市id
 *  @param needToken 请求是否需要token
 *  @param type      请求失败时弹出的提示类型
 *
 *  @return 登陆接口请求的唯一标示
 */
-(NSUInteger)requestLoginWithUserName:(NSString *)userName password:(NSString *)password cityId:(NSString *)cityId isNeedToken:(BOOL)needToken andAlertType:(FailueType)failueType;
@end
