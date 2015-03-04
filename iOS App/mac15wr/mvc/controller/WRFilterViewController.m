//
//  WRFilterViewController.m
//  mac15wr
//
//  Created by Alex on 2/27/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import "WRFilterViewController.h"

@interface WRFilterViewController ()
@property NSArray *term;
@property NSArray *dept;
@property NSArray *classT;
@property NSArray *pRating;
@property NSArray *cRating;
@property NSArray *sTime;
@property NSArray *eTime;
@end

@implementation WRFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.term=@[@"20151",@"20143",@"20152"];
    self.classT=@[@"Lecture",@"Discussion",@"Lab"];
    self.pRating=@[@"",@"1",@"2",@"3",@"4",@"5"];
    self.cRating=@[@"",@"1",@"2",@"3",@"4",@"5"];
    self.dept=@[@"",@"CSCI",@"INF"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


// The number of columns of data
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if ([pickerView isEqual:self.termPickView]) {
        return (int)1;
    }
    if ([pickerView isEqual:self.classTypePickView]) {
        return (int)1;
    }
    if ([pickerView isEqual:self.deptPickView]) {
        return (int)1;
    }
    if ([pickerView isEqual:self.professorRatingPickView]) {
        return (int)1;
    }
    if ([pickerView isEqual:self.courseRatingPickView]) {
        return (int)1;
    }
    return (int)1;
}

// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ([pickerView isEqual:self.termPickView]) {
        return (int)[self.term count];
    }
    if ([pickerView isEqual:self.classTypePickView]) {
        return (int)[self.classT count];
    }
    if ([pickerView isEqual:self.deptPickView]) {
        return (int)[self.dept count];
    }
    if ([pickerView isEqual:self.professorRatingPickView]) {
        return (int)[self.pRating count];
    }
    if ([pickerView isEqual:self.courseRatingPickView]) {
        return (int)[self.cRating count];
    }
    return 1;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if ([pickerView isEqual:self.termPickView]) {
        return self.term[row];
    }
    if ([pickerView isEqual:self.classTypePickView]) {
        return self.classT[row];
    }
    if ([pickerView isEqual:self.deptPickView]) {
        return self.dept[row];
    }
    if ([pickerView isEqual:self.professorRatingPickView]) {
        return self.pRating[row];
    }
    if ([pickerView isEqual:self.courseRatingPickView]) {
        return self.cRating[row];
    }
    return @"";
}

- (IBAction)SubmitFilterConditions:(id)sender {
  /*  RLMRealm *realm=[RLMRealm defaultRealm];
    
    
    NSString *searchconditionString=[WRFetchData searchCourseByCoditions:[WRFetchData
                                                                          stringOfCourseSerchConditonsWithCourseRating:[self.cRating objectAtIndex:[self.courseRatingPickView selectedRowInComponent:0]]
                                                                          ProfRating:[self.cRating objectAtIndex:[self.professorRatingPickView selectedRowInComponent:0]]
                                                                          Day:nil
                                                                          TimeStart:nil
                                                                          TimeEnd:nil
                                                                          TimeTypeAsInclude:@""]
                                                                    Term:[self.term
                                                                          objectAtIndex:[self.termPickView
                                                                                         selectedRowInComponent:0]] Dept:[self.dept objectAtIndex:[self.deptPickView selectedRowInComponent:0]]];
    
    [[WRAPIClient sharedClient] GET:searchconditionString parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSMutableArray* mutableCourses = [NSMutableArray arrayWithCapacity:[JSON count]];
        [realm beginWriteTransaction];
        [realm deleteObjects:[WRRealmCourse allObjects]];
        
        for (NSDictionary *course_attributes in JSON) {
            WRCourse *course = [[WRCourse alloc] initWithAttributes:course_attributes];
            
            if ([WRRealmCourse objectsWhere:@"sis_course_id=%@",course.sis_course_id].count) {
                continue;
            }
            
            
            WRRealmCourse *newcourse=[[WRRealmCourse alloc] init];
            newcourse.course_id=course.course_id;
            newcourse.sis_course_id=course.sis_course_id;
            newcourse.title=course.title;
            newcourse.min_units=course.min_units;
            newcourse.max_units=course.max_units;
            newcourse.total_max_units=course.total_max_units;
            newcourse.desc=course.desc;
            newcourse.diversity_flag=course.diversity_flag;
            newcourse.effective_term_code=course.effective_term_code;
            newcourse.section=[NSKeyedArchiver archivedDataWithRootObject:course.section];
            [realm addObject:newcourse];
            [mutableCourses addObject:course];
        }
        
        
        [realm commitWriteTransaction];
        
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        
    }];*/
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}







@end
