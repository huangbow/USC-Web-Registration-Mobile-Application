//
//  WRFetchData.m
//  mac15wr
//
//  Created by Alex on 2/26/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import "WRFetchData.h"
@interface WRFetchData()
@property NSMutableArray* mutableCourses;
@end
@implementation WRFetchData

+ (NSString*)getCourseInSpecificTerm:(NSString *)terms {
    NSString *getString=[[NSString alloc]initWithFormat:@"course/search/%@",terms];
    return getString;
}

+(NSString*)getCourseInSpecificTerm: (NSString*) terms andDept:(NSString*) dept {
    
    NSString *getString=[[NSString alloc]initWithFormat:@"course/search/%@/%@",terms,dept];
//    [[WRAPIClient sharedClient] GET:getString parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
//        self.mutableCourses = [NSMutableArray arrayWithCapacity:[JSON count]];
//        for (NSDictionary *course_attributes in JSON) {
//            
//            WRCourse *course = [[WRCourse alloc] initWithAttributes:course_attributes];
//            [self.mutableCourses addObject:course];
//        }
//
//    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
//        NSLog(@"Fetch Data Error");
//    }];
//    if ([self.mutableCourses isEqual:nil]) {
//        return nil;
//    }
    return getString;
}

+ (NSString*)getSchoolList {
    return @"misc/dept";
}

+ (NSString*)getAvailabelTerm {
    NSString *getString=@"misc/term";
    return getString;
}
+ (NSString*)getAllProfessors {
    NSString *getString=@"misc/prof/All";
    return getString;
}

+ (NSString*)stringOfCourseSerchConditonsWithCourseRating:(NSString*)cRating
                                         ProfRating:(NSString*)pRating
                                                Day:(NSInteger*)day
                                          TimeStart:(NSInteger*)tStart
                                            TimeEnd:(NSInteger*)tEnd
                                  TimeTypeAsInclude:(NSString*)tType {
    return [[NSString alloc]
            initWithFormat:@"?cRating=%@&pRating=%@&day=%zn&tStart=%zn&tEnd=%zn&tType=%@",
            cRating,pRating,day,tStart,tEnd,tType];
}

+ (NSString*)searchCourseByCoditions:(NSString*)conditions
                               Term:(NSString*) term
                               Dept:(NSString*)dept{
    NSString *getString=[[NSString alloc]
                         initWithFormat:@"course/search/%@/%@%@",
                         term,dept,conditions];
    
    return getString;
}



@end
