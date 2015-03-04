//
//  ViewController.h
//  mac15wr
//
//  Created by zwein on 15/2/7.
//  Copyright (c) 2015年 mac15wr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WRCourse.h"
#import "WRCourseTableViewController.h"

@interface ViewController : UIViewController

@property (nonatomic, strong)  WRCourse *course;
@property NSString *email;


@property (weak, nonatomic) IBOutlet UINavigationItem *naviItem;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *submitBarButton;

@end

@class GPPSignInButton;