//
//  ViewController.m
//  ManualUpdateTest
//
//  Created by LY'S MacBook Air on 10/12/15.
//  Copyright © 2015 LY'S MacBook Air. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic,strong) HttpService *currentService;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.currentService = [[HttpService alloc] init];
    self.currentService.delegate = self ;
    
   self.loginHttpTag= [self.currentService requestLoginWithUserName:@"15678332798" password:@"1" cityId:@"1" isNeedToken:NO andAlertType:AlertFailueType];
    
//   self.quoteHttpTag = [self.currentService requestSupplierGoodsInfoBySid:nil isNeedToken:YES andAlertType:AlertFailueType];
    
}




-(void)requestSuccess:(HttpResponse *)response
{
    if (response.httpTag ==_loginHttpTag)
    {
        //保存token在本地[NSUserdefault]
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"token"];
    }
    else if (response.httpTag == _quoteHttpTag)
    {
        
    }
}

-(void)requestFailue:(HttpResponse *)response
{
    if (response.httpTag ==_loginHttpTag)
    {
        NSLog(@"----response=%@",response.responseObject);
    }
    else if (response.httpTag == _quoteHttpTag)
    {
        
    }
}

@end
