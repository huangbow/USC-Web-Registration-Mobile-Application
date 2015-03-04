//
//  WRDataFormatChange.h
//  mac15wr
//
//  Created by Alex on 2/27/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WRDataFormatChange : NSObject


+ (NSData*) NSDictionary2NSData:(NSDictionary *)dic;
+ (NSDictionary*) NSData2NSDictionary:(NSData *)data;
+ (NSMutableArray *)NSData2NSMutableArray:(NSData*)data;
+ (NSArray *)NSData2NSArray:(NSData*)data;
+ (NSData*)NSArray2NSData:(NSArray*)array;
+ (NSData*)NSMutableArray2NSData:(NSMutableArray*)array;


@end
