//
//  TopViewController.h
//  mac15wr
//
//  Created by zwein on 2/14/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WRFiveViewController.h"
#import "KVNMaskedPageControl.h"
#import "CenterViewController.h"
#import "MAWeekView.h" // MAWeekViewDataSource,MAWeekViewDelegate

@class MAEventKitDataSource;



@interface TopViewController : WRFiveViewController <UIScrollViewDelegate, KVNMaskedPageControlDataSource,MAWeekViewDataSource,MAWeekViewDelegate>{
    MAEventKitDataSource *_eventKitDataSource;
}
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) KVNMaskedPageControl *pageControl;
@property (strong, nonatomic) CenterViewController *centerViewControllerDelegate;

@property (strong, nonatomic) NSMutableArray *calendarViews;

-(void) presentViewContent;
-(void) hideViewContent;
@end
