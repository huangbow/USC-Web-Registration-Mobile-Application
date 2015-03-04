//
//  APIClient.m
//  mac15wr
//
//  Created by zwein on 2/9/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import "WRAPIClient.h"

static NSString * const WRAPIBaseURLString = @"http://52.1.208.251/";

@implementation WRAPIClient

+ (instancetype)sharedClient {
    static WRAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[WRAPIClient alloc] initWithBaseURL:[NSURL URLWithString:WRAPIBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}


@end
