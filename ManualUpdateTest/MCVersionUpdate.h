//
//  MCVersionUpdate.h
//  ManualUpdateTest
//
//  Created by LY'S MacBook Air on 10/13/15.
//  Copyright © 2015 LY'S MacBook Air. All rights reserved.
//

/**
 *  在线参数样式:1(是否更新)^app.yunshanmeicai.com/supply(更新链接)^1.0-2,1.1-1,1.2-0(0:不更新,1:选择更新,2.强制更新)
 */


#import <Foundation/Foundation.h>
#import "MobClick.h"

@interface MCVersionUpdate : NSObject

+ (id)shareManager;

/**
 *  获取在线的参数
 */
- (void)onlineUpdateParameters;

@end
