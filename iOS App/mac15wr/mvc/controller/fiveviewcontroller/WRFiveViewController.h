//
//  WRFiveViewController.h
//  mac15wr
//
//  Created by zwein on 2/14/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ICGViewController.h"

/**
 *  Mother Controller for center, left, right, top and bottom controller
 *  Set these common properties here
 */
@interface WRFiveViewController : UIViewController
@property (nonatomic) UIColor *bgColor;
-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer;
@end
