//
//  WRSection.h
//  mac15wr
//
//  Created by Alex on 2/26/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WRSection : NSObject
@property NSString* type;
@property NSString* uSectionID;
@property NSInteger sectionID;
@property NSString* termCode;
@property NSInteger minUnits;
@property NSInteger maxUnits;
@property NSString* bTime;
@property NSString* eTime;
@property NSString* day;
@property NSInteger iDay;
@property NSString* location;
@property NSInteger registered;
@property NSInteger seat;
@property NSString* instructor;
@property NSString* iRating;
@property NSString* addBy;
@property NSString* dropBy;
@property NSString* pFlag;
@property NSString* pSecFlag;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end
