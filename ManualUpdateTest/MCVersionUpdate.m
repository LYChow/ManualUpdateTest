//
//  MCVersionUpdate.m
//  ManualUpdateTest
//
//  Created by LY'S MacBook Air on 10/13/15.
//  Copyright © 2015 LY'S MacBook Air. All rights reserved.
//

#import "MCVersionUpdate.h"
#import "Reachability.h"

#define kAppUpdateTitle @"供应商有新的版本"
#define kChoiceUpdateTag  111
#define kForceUpdateTag   222
#define kWWANAlertTag     333

typedef enum : NSUInteger {
    UMengServicesType,
    OwnerServicesType
} ServicesType;

@interface MCVersionUpdate()<UIAlertViewDelegate>

/**
 *  更新服务器在线参数时使用的服务器类型 自己的服务器/Umeng的服务器
 */
@property(nonatomic,assign) ServicesType type;
/**
 *  更新的URl
 */
@property(nonatomic,strong) NSString *appDownloadPath;

@property(nonatomic,strong) NSArray *versionsArray;
@end

@implementation MCVersionUpdate


-(instancetype)init
{
    if (self = [super init])
    {
        _type = UMengServicesType;
    }
    return self;
}

+ (id)shareManager
{
    static MCVersionUpdate *update=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        update = [[MCVersionUpdate alloc] init];
    });
    return update;
}

-(NSArray *)versionsArray
{
    if (_versionsArray == nil) {
        _versionsArray =[[NSArray alloc] init];
    }
    return _versionsArray;
}

/**
 *  监听UMeng在线更新的参数
 */
- (void)onlineUpdateParameters
{
    switch (_type) {
        case UMengServicesType:
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appInfo:) name:UMOnlineConfigDidFinishedNotification object:nil];
            break;
        case OwnerServicesType:
            //获取我们自己的
            break;
        default:
            break;
    }
}

-(void)appInfo:(NSNotification *)noti
{
    //"update_mc_ios" = "1^https://app.yunshanmeicai.com/supply/supplier.html^1.0-2,1.1-1,1.2-0"
    
    NSString *onlineParamsStr=[noti.userInfo objectForKey:@"update_mc_ios"];
    if (onlineParamsStr.length) {
        if ([onlineParamsStr containsString:@"^"])
        {
            NSArray *params =[onlineParamsStr componentsSeparatedByString:@"^"];
            //判断是否更新
            if ([params[0] isEqualToString:@"1"])
            {
                _appDownloadPath =params[1];
    
                if ([params[2] containsString:@","]) {
                    NSArray *versions =[params[2] componentsSeparatedByString:@","];
                    
                    self.versionsArray = versions;
                    for (NSString *versionInfoStr in self.versionsArray)
                    {
                        if ([versionInfoStr containsString:@"-"]) {
                            NSArray *versionInfo =[versionInfoStr componentsSeparatedByString:@"-"];
                            
                            NSDictionary *versionDic =[NSDictionary dictionaryWithObjectsAndKeys:[versionInfo firstObject],@"version",[versionInfo lastObject],@"updateCode",nil];
                            
                            [self updateAlertType:versionDic];
                        }
                    }
                }
            }
        }
  
    }
        
}


-(void)updateAlertType:(NSDictionary *)versionInfo
{
   
    if ([[versionInfo objectForKey:@"version"] isEqualToString:XcodeAppVersion])
    {
        switch ([[versionInfo objectForKey:@"updateCode"] integerValue]) {
            case 0:
                
                break;
            case 1:
            {
                UIAlertView *alert =[[UIAlertView alloc] initWithTitle:kAppUpdateTitle message:@"是否更新供应商" delegate:self cancelButtonTitle:@"跳过" otherButtonTitles:@"更新", nil];
                [alert show];
                alert.tag =kChoiceUpdateTag;
            }
                break;
            case 2:
            {
                UIAlertView *alert =[[UIAlertView alloc] initWithTitle:kAppUpdateTitle message:@"供应商有新的版本" delegate:self cancelButtonTitle:@"马上更新" otherButtonTitles:nil];
                [alert show];
                alert.tag =kForceUpdateTag;
            }
                break;
            default:
                break;
        }
    }
}

#pragma mark UIAlertDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ((alertView.tag  == kChoiceUpdateTag && buttonIndex==1) || (alertView.tag == kForceUpdateTag && buttonIndex==0))
    {
        
//         #warning 非WIFI情况下提示是否现在下载
        switch ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus]) {
            case ReachableViaWiFi:
            {
                NSURL *url = [NSURL URLWithString:self.appDownloadPath];
                [[UIApplication sharedApplication] openURL:url];
            }
                break;
            case ReachableViaWWAN:
            {
                UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"当前是移动网络" message:@"确定要更新吗" delegate:self cancelButtonTitle:@"暂不更新" otherButtonTitles:@"马上更新", nil];
                [alert show];
                alert.tag =kWWANAlertTag;
            }
                break;
            default:
                break;
        }
        ;
    }
    else if (alertView.tag == kWWANAlertTag && buttonIndex==1)
    {
        NSURL *url = [NSURL URLWithString:self.appDownloadPath];
        [[UIApplication sharedApplication] openURL:url];
    }
    
}




@end
