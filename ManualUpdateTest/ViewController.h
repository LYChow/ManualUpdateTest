//
//  ViewController.h
//  ManualUpdateTest
//
//  Created by LY'S MacBook Air on 10/12/15.
//  Copyright © 2015 LY'S MacBook Air. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpService.h"

@interface ViewController : UIViewController<HttpServiceDelegate>

/**
 *  报价请求时生成的Tag
 */
@property(nonatomic,assign) NSUInteger quoteHttpTag;

/**
 *  登陆请求时生成的Tag
 */
@property(nonatomic,assign) NSUInteger loginHttpTag;

@end

