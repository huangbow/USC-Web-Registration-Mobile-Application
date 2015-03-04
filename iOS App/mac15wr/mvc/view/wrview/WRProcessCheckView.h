//
//  WRProcessCheckView.h
//  mac15wr
//
//  Created by zwein on 2/16/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "KLCPopup.h"
#include "CenterViewController.h"
/**
 *  Process Check
 *
 *  1)  App "Tutorial"
            a) Overview Tour
            b) Team Member
 *  2)  Information "Viewer"
            a) Course in USC
            b) Course Requirement -> give a page to prerequired course related to students' major
            c) Course Recommendation
            d) Registration
 *  3)  Course "Chooser"
            a) Choose course
            b) Check wish lish
            c) Check reminder
            d) Check checkout list
            e) View calendar
            f) Compare Calendars
            g) Check Credits
 *  4)  Course "Register"
            a) Course Examination Report    - i.e. four course in a semester, difficult. or, based on difficult of course
            b) DC Requester
            c) Checkout and Pay
 *  5)  Course "Planner"
            a) Overview Report      - examine all courses or credits finished by student
            b) Statistical Report   - i.e.  the rating of this courses
            c) plan course          - in a table list separated by different semesters
 */
@interface WRProcessCheckView : UIView<UITableViewDataSource,
UITableViewDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton* dismissButton;
//@property (nonatomic, strong) UILabel *descLabel;

@property (nonatomic, strong) UITableView *checklistTable;
@property (nonatomic, strong) NSMutableArray *checklistContent;

@property (nonatomic, strong) CenterViewController *parentControllerDelegate;
@property (nonatomic, strong) KLCPopup *klcPopupDelegate;

@property (nonatomic, strong) NSString *cvTypeString;

- (id) initWithCVType:(NSString*)cvType;

@end
