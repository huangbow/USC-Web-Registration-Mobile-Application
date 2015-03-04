//
//  APIClient.h
//  mac15wr
//
//  Created by zwein on 2/9/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface WRAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end