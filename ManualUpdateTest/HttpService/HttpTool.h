//
//  HttpTool.h
//  ManualUpdateTest
//
//  Created by LY'S MacBook Air on 10/16/15.
//  Copyright © 2015 LY'S MacBook Air. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpTool : NSObject
+ (HttpTool *)shareManager;

+(NSUInteger)generateUniqueTag;

@end
