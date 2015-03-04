//
//  WRCourse.h
//  mac15wr
//
//  Created by zwein on 2/9/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//


#import "JSONModel.h"

@interface WRCourse : NSObject

@property (assign, nonatomic) NSInteger course_id;
@property (strong, nonatomic) NSString* sis_course_id;
@property (strong, nonatomic) NSString* title;
@property (assign, nonatomic) NSInteger min_units;
@property (assign, nonatomic) NSInteger max_units;
@property (assign, nonatomic) NSInteger total_max_units;
@property (strong, nonatomic) NSString* desc;
@property (strong, nonatomic) NSString* diversity_flag;
@property (strong, nonatomic) NSString* effective_term_code;

@property (strong, nonatomic) NSArray* section;


- (instancetype)initWithAttributes:(NSDictionary *)attributes;


@end