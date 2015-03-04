//
//  WRSchoolList.h
//  mac15wr
//
//  Created by Alex on 2/26/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WRSchool.h"

@interface WRSchoolList : NSObject
@property NSArray* schoolList;
@property NSArray* deptsInSchool;
@property WRSchool* school;
- (instancetype)initWithAttributes:(NSDictionary *)attributes;
@end
