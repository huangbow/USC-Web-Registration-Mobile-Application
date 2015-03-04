//
//  WRDataFormatChange.m
//  mac15wr
//
//  Created by Alex on 2/27/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import "WRDataFormatChange.h"

@implementation WRDataFormatChange


+ (NSData*)NSDictionary2NSData:(NSDictionary *)dic {
    NSData* data=[[NSData alloc]
                  initWithData:[NSJSONSerialization
                                dataWithJSONObject:dic
                                    options:0
                                      error:nil]];
    return data;
    
}

+ (NSDictionary *)NSData2NSDictionary:(NSData *)data {
    NSDictionary *jsonDic=[[NSDictionary alloc]
                           initWithDictionary:[NSJSONSerialization
                              JSONObjectWithData:data
                              options:NSJSONReadingMutableLeaves
                              error:nil]];
    return jsonDic;

}


+ (NSMutableArray *)NSData2NSMutableArray:(NSData*)data {
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

+ (NSArray *)NSData2NSArray:(NSData*)data {
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}




+ (NSData*)NSArray2NSData:(NSArray*)array {
    return [NSKeyedArchiver archivedDataWithRootObject:array];
}

+ (NSData*)NSMutableArray2NSData:(NSMutableArray*)array {
    return [NSKeyedArchiver archivedDataWithRootObject:array];
}






@end
