//
//  WRLoginViewController.h
//  mac15wr
//
//  Created by Alex on 2/14/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GooglePlus/GooglePlus.h>
#import "WRCourse.h"
#import "AppDelegate.h"

@interface WRLoginViewController : UIViewController<GPPSignInDelegate>

@property (nonatomic, strong)  WRCourse *course;
@property NSMutableArray *mutableCourses;

@property (retain, nonatomic) IBOutlet GPPSignInButton *signInButton;
@property GPPSignIn *signIn;

@property (nonatomic, strong) AppDelegate *appDelegate;


@end
