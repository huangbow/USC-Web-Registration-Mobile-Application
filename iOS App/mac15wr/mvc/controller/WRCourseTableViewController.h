//
//  WRCourseTableViewController.h
//  mac15wr
//
//  Created by Alex on 2/13/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WRCourse.h"
#import "MGSwipeTableCell.h"
#import "MGSwipeButton.h"
#import "WRCourseTableViewCell.h"
#import "CenterViewController.h"

@interface WRCourseTableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, MGSwipeTableCellDelegate, UIActionSheetDelegate>

//@property NSMutableArray *mutableCourses;
@property RLMResults *mutableCourses;
@property (strong,nonatomic) NSMutableArray *filteredCourseArray;
@property IBOutlet UISearchBar *courseSearchBar;
@property WRRealmCourse *courseSelected;
@property (strong, nonatomic) IBOutlet UITableView *tableview;

@property (strong,nonatomic) CenterViewController *centerViewControllerDelegate;


@end
