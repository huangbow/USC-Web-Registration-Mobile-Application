//
//  BottomViewController.h
//  mac15wr
//
//  Created by zwein on 2/14/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WRFiveViewController.h"
#import "CenterViewController.h"

@interface BottomViewController : WRFiveViewController
@property (strong, nonatomic) CenterViewController *centerViewControllerDelegate;

-(void) presentViewContent;
-(void) hideViewContent;

@end
