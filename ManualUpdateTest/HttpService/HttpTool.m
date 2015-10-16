//
//  HttpTool.m
//  ManualUpdateTest
//
//  Created by LY'S MacBook Air on 10/16/15.
//  Copyright © 2015 LY'S MacBook Air. All rights reserved.
//

#import "HttpTool.h"

@implementation HttpTool

+ (HttpTool *)shareManager
{
    static HttpTool *httpTool = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        httpTool = [[HttpTool alloc] init];
    });
    return httpTool;
}

+(NSUInteger)generateUniqueTag
{
  static NSUInteger tag = 0;
  tag++;
  return tag;
}

@end
