//
//  HttpService.m
//  ManualUpdateTest
//
//  Created by LY'S MacBook Air on 10/16/15.
//  Copyright © 2015 LY'S MacBook Air. All rights reserved.
//

#import "HttpService.h"
#import "HttpTool.h"

static float requestTimeOut = 10.0;
@implementation HttpService

- (HttpService *)currentService
{
    if (!_currentService) {
        _currentService =[[HttpService alloc] init];
    }
    return _currentService;
}

-(NSUInteger)requestSupplierGoodsInfoBySid:(NSString *)sid isNeedToken:(BOOL)needToken andAlertType:(FailueType)failueType
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (sid) {
        params[@"sid"]=sid;
    }
    [self packParameters:params WithToken:needToken];
    
    
    //生成唯一标示的Tag
    NSUInteger identifyTag = [HttpTool generateUniqueTag];

    [HttpClient postRequestWithUrl:[NSString stringWithFormat:@"%@%@",BaseUrl,APP_GetSupplierGoods] Parametes:params requestSuccess:^(id sucessResponse) {
        HttpResponse *response =[[HttpResponse alloc] init];
        response.responseObject=sucessResponse;
        response.httpTag=identifyTag;
        
        [self handleSuceess:response alertType:failueType];
    } requestFailue:^(NSError *error) {
        HttpResponse *response = [[HttpResponse alloc]init];
        response.error=error;
        response.httpTag = identifyTag;
        
        [self handleFailue:response alertType:failueType];
    } requestTimeout:requestTimeOut isEncryption:YES];
    
    return identifyTag;
}


-(NSUInteger)requestLoginWithUserName:(NSString *)userName password:(NSString *)password cityId:(NSString *)cityId isNeedToken:(BOOL)needToken andAlertType:(FailueType)failueType
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"phone"]=userName;
    params[@"password"]=password;
    params[@"cityid"]=cityId;
    [self packParameters:params WithToken:needToken];
    
    //生成唯一标示的Tag
    NSUInteger identifyTag = [HttpTool generateUniqueTag];
    
    [HttpClient postRequestWithUrl:[NSString stringWithFormat:@"%@%@",BaseUrl,APP_GetSupplierGoods] Parametes:params requestSuccess:^(id sucessResponse) {
        HttpResponse *response =[[HttpResponse alloc] init];
        response.responseObject=sucessResponse;
        response.httpTag=identifyTag;
        
        [self handleSuceess:response alertType:failueType];
    } requestFailue:^(NSError *error) {
        HttpResponse *response = [[HttpResponse alloc]init];
        response.error=error;
        response.httpTag = identifyTag;
        
        [self handleFailue:response alertType:failueType];
    } requestTimeout:requestTimeOut isEncryption:YES];
    
    return identifyTag;

}

#pragma mark -数据请求的回调Delegate

-(void)handleSuceess:(HttpResponse *)response alertType:(FailueType)failueType
{
    _isRequestSuccessError=NO;
    
    if ([[response.responseObject objectForKey:@"ret"] integerValue] ==1)
    {
        if ([_delegate respondsToSelector:@selector(requestSuccess:)]) {
            [_delegate requestSuccess:response];
        }
    }
    else
    {
        _isRequestSuccessError = YES;
        if ([_delegate respondsToSelector:@selector(requestFailue:)]) {
            [self showErrorInfoWithResponse:response useAlertType:failueType];
            [_delegate requestFailue:response];
        }
    }
}

-(void)handleFailue:(HttpResponse *)response alertType:(FailueType)failueType
{
    if ([_delegate respondsToSelector:@selector(requestFailue:)]) {
        [self showErrorInfoWithResponse:response useAlertType:failueType];
        [_delegate requestFailue:response];
    }
}

#pragma mark -网络请求失败 弹出失败信息
-(void)showErrorInfoWithResponse:(HttpResponse *)response useAlertType:(FailueType)failueType
{
    
    
    
     NSString *errorStr=@"";
    //解析出错误的信息
    if ([[response.responseObject objectForKey:@"error"] isKindOfClass:[NSDictionary class]] &&_isRequestSuccessError) {
        NSDictionary *errInfos = [response.responseObject objectForKey:@"error"];
        errorStr =[NSString stringWithFormat:@"错误信息:%@ 错误码:%@",errInfos[@"msg"],errInfos[@"code"]];
    }
    else
    {
        errorStr=@"请检查你的网络设置";
    }
    
    switch (failueType) {
        case NoneFailueType:
            
            break;
        case AlertFailueType:
            [self showAlertWithErrorInfo:errorStr];
            break;
        case ToastFailueType:
            [self showToastWithErrorInfo:errorStr];
            break;
        default:
            break;
    }
}

-(void)showAlertWithErrorInfo:(NSString *)errInfo
{
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"请求失败" message:errInfo delegate:nil cancelButtonTitle:@"OK!" otherButtonTitles:nil];
    [alert show];
}

-(void)showToastWithErrorInfo:(NSString*)errInfo
{

}

#pragma mark -给参数列表设置Token
-(void)packParameters:(NSMutableDictionary *)params  WithToken:(BOOL)needToken
{
    if (needToken  && [[NSUserDefaults standardUserDefaults] objectForKey:@"token"]) {
    params[@"token"]=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    }
    
    //传一些无关紧要的参数
}

@end
