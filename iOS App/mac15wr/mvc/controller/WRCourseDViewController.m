//
//  WRCourseDViewController.m
//  mac15wr
//
//  Created by Alex on 2/25/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import "WRCourseDViewController.h"
#import "WRDescTableViewCell.h"
#import "WRSectionTableViewCell.h"
#import "WRSection.h"
#import "WRRealmCheckList.h"
#import "WRRealmWishList.h"
#import "WRFiveViewManager.h"
#import <Realm/Realm.h>
#import "RightViewController.h"

@implementation WRCourseDViewController


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.sections count]+1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sections" forIndexPath:indexPath];
    // Configure the cell...
    
    if (indexPath.row==0) {
        //show description
        WRDescTableViewCell *celldesc = [tableView dequeueReusableCellWithIdentifier:@"desc"];
        celldesc.descLabel.text=self.courseSelected.desc;
        CGSize labelSize = [celldesc.descLabel.text sizeWithAttributes:@{NSFontAttributeName:celldesc.descLabel.font}];
        
        celldesc.descLabel.frame = CGRectMake(
                                 celldesc.descLabel.frame.origin.x, celldesc.descLabel.frame.origin.y,
                                 celldesc.descLabel.frame.size.width, labelSize.height);
        return celldesc;
    }else{
        WRSectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sections"];
        WRSection *section=[[WRSection alloc]
                            initWithAttributes:[self.sections
                                                objectAtIndex:indexPath.row-1]];
        cell.classNumLabel.text=section.uSectionID;
        //seat,registered,waiting
        cell.srwLabel.text=[[NSString alloc]
                            initWithFormat:@"S%d/R%d/W%@",
                            (int)section.seat,
                            (int)section.registered,
                            @"0"];;
        
        cell.roomLabel.text=[[self.sections objectAtIndex:indexPath.row-1] valueForKey:@"location"];
        cell.hoursLabel.text=[[NSString alloc]
                              initWithFormat:@"%@-%@",
                              section.bTime,section.eTime];
        
        cell.instractorLabel.text=section.instructor;
        cell.dayLabel.text=section.day;
        
        //classtype
        cell.courseTypeLabel.text=section.type;
        
        
        
        return cell;
        
    }
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 140;
    }
    else {
        return 100;
    }
}



-(void)viewDidLoad {
    self.courseTitleLabel.text=self.courseSelected.title;
    self.courseIDLabel.text=self.courseSelected.sis_course_id;
    
    
    NSMutableArray *sec=[WRDataFormatChange NSData2NSMutableArray:self.courseSelected.section];
    self.sections=[[NSMutableArray alloc] init];
    for (NSDictionary *dict in sec) {
        [self.sections addObject:dict];
    }
    
    
    UIView * separator = [[UIView alloc] initWithFrame:CGRectMake(0, 235, 600, 0.5)];
    separator.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
    [self.view addSubview:separator];
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    v.backgroundColor = [UIColor clearColor];
    [self.tableview setTableFooterView:v];
    
}


- (IBAction)addToCheckList:(id)sender {
    NSInteger row=[[self.tableview indexPathForSelectedRow] row];
    
    //realm, data put in
    RLMRealm *defaultRealm = [RLMRealm defaultRealm];
    WRRealmCheckList *checklist=[[WRRealmCheckList alloc] init];
    [defaultRealm beginWriteTransaction];
    
    checklist.section=[WRDataFormatChange NSDictionary2NSData:[self.sections objectAtIndex:row]];

    
    checklist.sis_course_id=self.courseSelected.sis_course_id;
    checklist.title=self.courseSelected.title;
    [defaultRealm addObject:checklist];
    
    [defaultRealm commitWriteTransaction];
    
    RightViewController *rightViewController = (RightViewController*)self.courseTableViewDelegate.centerViewControllerDelegate.viewDeckController.rightController;
    
    [rightViewController.checkoutTable loadData];
    [rightViewController.checkoutTable reloadData];
    
    //return mainview
    NSLog(@"pop");
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addToWishList:(id)sender {
    
    NSInteger row=[[self.tableview indexPathForSelectedRow] row];
    
    RLMRealm *defaultRealm = [RLMRealm defaultRealm];
    WRRealmWishList *wishlist=[[WRRealmWishList alloc] init];
    [defaultRealm beginWriteTransaction];
    
    wishlist.section=[WRDataFormatChange NSDictionary2NSData:[self.sections objectAtIndex:row]];
    
    
    wishlist.sis_course_id=self.courseSelected.sis_course_id;
    wishlist.title=self.courseSelected.title;
    [defaultRealm addObject:wishlist];
    
    [defaultRealm commitWriteTransaction];
    
    
    //return mainview
    NSLog(@"pop");
    [self dismissViewControllerAnimated:YES completion:nil];

    
}



@end
