//
//  WRFetchData.h
//  mac15wr
//
//  Created by Alex on 2/26/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WRAPIClient.h"
#import "WRCourse.h"

@interface WRFetchData : NSObject
@property NSDictionary* data;


+ (NSString*)getCourseInSpecificTerm: (NSString*) terms andDept:(NSString*) dept;
+ (NSString*)getCourseInSpecificTerm: (NSString*) terms;
+ (NSString*)getSchoolList;
+ (NSString*)getAvailabelTerm;
+ (NSString*)getAllProfessors;

+ (NSString*)stringOfCourseSerchConditonsWithCourseRating:(NSString*)cRating
                                         ProfRating:(NSString*)pRating
                                                Day:(NSInteger*)day
                                          TimeStart:(NSInteger*)tStart
                                            TimeEnd:(NSInteger*)tEnd
                                  TimeTypeAsInclude:(NSString*)tType;


+ (NSString*)searchCourseByCoditions:(NSString*)conditions
                               Term:(NSString*) term
                               Dept:(NSString*)dept;


@end
