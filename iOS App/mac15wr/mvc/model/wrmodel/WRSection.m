//
//  WRSection.m
//  mac15wr
//
//  Created by Alex on 2/26/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import "WRSection.h"

@implementation WRSection

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    self.type=(NSString*)[attributes valueForKey:@"type"];
    self.uSectionID=(NSString*)[attributes valueForKey:@"uSectionID"];
    self.sectionID=[[attributes valueForKey:@"sectionID"] integerValue];
    
    self.termCode=(NSString*)[attributes valueForKey:@"termCode"];
    self.minUnits=[[attributes valueForKey:@"minUnits"] integerValue];
    self.maxUnits=[[attributes valueForKey:@"maxUnits"] integerValue];
    self.bTime=(NSString*)[attributes valueForKey:@"bTime"];
    self.eTime=(NSString*)[attributes valueForKey:@"eTime"];
    self.day=(NSString*)[attributes valueForKey:@"day"];
    self.iDay=[[attributes valueForKey:@"iDay"] integerValue];
    self.location=(NSString*)[attributes valueForKey:@"location"];
    self.registered=[[attributes valueForKey:@"registered"] integerValue];
    self.seat=[[attributes valueForKey:@"seat"] integerValue];
    self.instructor=(NSString*)[attributes valueForKey:@"instructor"];
    self.iRating=(NSString*)[attributes valueForKey:@"iRating"];
    self.addBy=(NSString*)[attributes valueForKey:@"addBy"];
    self.dropBy=(NSString*)[attributes valueForKey:@"dropBy"];
    self.pFlag=(NSString*)[attributes valueForKey:@"pFlag"];
    self.pSecFlag=(NSString*)[attributes valueForKey:@"pSecFlag"];
    
    return self;
}

@end
