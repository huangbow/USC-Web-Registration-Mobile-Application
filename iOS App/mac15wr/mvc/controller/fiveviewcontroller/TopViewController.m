//
//  TopViewController.m
//  mac15wr
//
//  Created by zwein on 2/14/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import "TopViewController.h"
#import "MAWeekView.h"
#import "MAEvent.h"
#import "MAEventKitDataSource.h"


#define DATE_COMPONENTS (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]


@interface TopViewController (){
    CGPoint containerCenter;
}

@property (readonly) MAEvent *event;
@property (readonly) MAEventKitDataSource *eventKitDataSource;

@end

@implementation TopViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - (SCREEN_HEIGHT/2-100));
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    containerCenter = self.scrollView.center;
    self.scrollView.center = CGPointMake(containerCenter.x, containerCenter.y - CGRectGetHeight(self.scrollView.frame));
    
    [self.view addSubview:self.scrollView];
    
    NSInteger pageNumber = 5;
    self.pageControl = self.centerViewControllerDelegate.pageControl;
    [self.pageControl setDataSource:self];
    [self.pageControl setNumberOfPages:pageNumber];

    [self createPages:pageNumber];
   
    
//    [self.view addSubview:weekView];

    [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
 
    

}

static int counter = 23;
- (NSArray *)weekView:(MAWeekView *)weekView eventsForDay:(int)WRWeekDays{
    counter--;

    
    unsigned int r = arc4random() % 24;
    unsigned int r2 = arc4random() % 10;
    
    NSArray *arr;
    
    arr = [NSArray arrayWithObjects: self.event, nil];
   
    
    ((MAEvent *) [arr objectAtIndex:0]).title = @"Test Event";
    ((MAEvent *) [arr objectAtIndex:0]).weekday = WRWeekDays;
    
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:[[NSDate alloc] init]];
    
    [components setHour:r];
    [components setMinute:0];
    [components setSecond:0];
    
    ((MAEvent *) [arr objectAtIndex:0]).start = [CURRENT_CALENDAR dateFromComponents:components];
    
    [components setHour:r+2];
    [components setMinute:0];
    
    ((MAEvent *) [arr objectAtIndex:0]).end = [CURRENT_CALENDAR dateFromComponents:components];
    
    if (r2 > 5) {
        ((MAEvent *) [arr objectAtIndex:0]).backgroundColor = [UIColor brownColor];
    }
    
    return arr;
    
    return nil;
}



- (MAEvent *)event {
    static int counter;
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:[NSString stringWithFormat:@"number %i", counter++] forKey:@"test"];
    
    MAEvent *event = [[MAEvent alloc] init];
    event.backgroundColor = [UIColor redColor];
    event.textColor = [UIColor whiteColor];
    event.allDay = NO;
    event.userInfo = dict;
    return event;
}

- (MAEventKitDataSource *)eventKitDataSource {
    if (!_eventKitDataSource) {
        _eventKitDataSource = [[MAEventKitDataSource alloc] init];
    }
    return _eventKitDataSource;
}

/* Implementation for the MAWeekViewDelegate protocol */

- (void)weekView:(MAWeekView *)weekView eventTapped:(MAEvent *)event {
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:event.start];
    NSString *eventInfo = [NSString stringWithFormat:@"Event tapped: %02i:%02i. Userinfo: %@", [components hour], [components minute], [event.userInfo objectForKey:@"test"]];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:event.title
                                                    message:eventInfo delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)weekView:(MAWeekView *)weekView eventDragged:(MAEvent *)event {
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:event.start];
    NSString *eventInfo = [NSString stringWithFormat:@"Event dragged to %02i:%02i. Userinfo: %@", [components hour], [components minute], [event.userInfo objectForKey:@"test"]];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:event.title
                                                    message:eventInfo delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}



- (void)createPages:(NSInteger)pages {
    self.calendarViews = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < pages; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.scrollView.bounds) * i, 0, CGRectGetWidth(self.scrollView.bounds), CGRectGetHeight(self.scrollView.bounds))];
        [view setBackgroundColor:[UIColor pomegranateColor]];
        
        MAWeekView *calenderView = [[MAWeekView alloc] init];
        calenderView.frame = CGRectMake(0, 0, CGRectGetWidth(self.scrollView.bounds)-40, CGRectGetHeight(self.scrollView.bounds)-40);

        calenderView.center = CGPointMake(CGRectGetWidth(self.scrollView.bounds)/2, CGRectGetHeight(self.scrollView.bounds)/2);
        calenderView.backgroundColor = [UIColor WR_USC_Red];
        calenderView.layer.masksToBounds = YES;
        calenderView.layer.cornerRadius = 15.0;
        calenderView.dataSource = self;
        calenderView.delegate = self;
        
        
        [view addSubview:calenderView];
        [self.calendarViews addObject:calenderView];
//        UILabel *label = [[UILabel alloc] init];
//        [label setText:[NSString stringWithFormat:@"%i", i+1]];
//        [label setFont:[UIFont boldSystemFontOfSize:90]];
//        
//        [label sizeToFit];
//        [label setCenter:CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds))];
//        
//        if (i % 2 == 0) {
//            [view setBackgroundColor:[UIColor darkGrayColor]];
//            [label setTextColor:[UIColor whiteColor]];
//        } else {
//            [view setBackgroundColor:[UIColor whiteColor]];
//            [label setTextColor:[UIColor darkGrayColor]];
//        }
        
//        [view addSubview:label];
        [self.scrollView addSubview:view];
    }
    
    [self.scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.scrollView.bounds) * pages, CGRectGetHeight(self.scrollView.bounds))];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.pageControl maskEventWithOffset:scrollView.contentOffset.x frame:scrollView.frame];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = self.scrollView.frame.size.width;
    NSInteger page =  floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    [self.pageControl setCurrentPage:page];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    CGFloat pageWidth = self.scrollView.frame.size.width;
    NSInteger page =  floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    [self.pageControl setCurrentPage:page];
}

#pragma mark - IBActions
- (void)changePage:(KVNMaskedPageControl *)sender {
    self.pageControl.currentPage = sender.currentPage;
    
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    [self.scrollView scrollRectToVisible:frame animated:YES];
}

#pragma mark - KVNMaskedPageControlDataSource
- (UIColor *)pageControl:(KVNMaskedPageControl *)control pageIndicatorTintColorForIndex:(NSInteger)index {
    if (index % 2 == 0) {
        return [UIColor colorWithWhite:1.0 alpha:.6];
    } else {
        return [UIColor colorWithWhite:0 alpha:.5];
    }
}

- (UIColor *)pageControl:(KVNMaskedPageControl *)control currentPageIndicatorTintColorForIndex:(NSInteger)index {
    if (index % 2 == 0) {
        return nil; // nil just sets the default UIPageControl color or respects UIAppearance setting.
    } else {
        return [UIColor colorWithWhite:0 alpha:.8];
        
    }
}


-(void) presentViewContent{
    [UIView animateWithDuration:FIVEPAGE_TRANSITION_DURATION animations:^{
        //[UIView setAnimationDelay:1.2];//配置动画时延
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.scrollView.center = containerCenter;//CGPointMake(bgCenter.x + 100, bgCenter.y);
        [self.scrollView setAlpha:1.0];
        
    } completion:^(BOOL finished) {
        //执行完后走这里的代码块
    }];
    
}


-(void) hideViewContent{
    [UIView animateWithDuration:FIVEPAGE_TRANSITION_DURATION animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.scrollView.center = CGPointMake(containerCenter.x, containerCenter.y - CGRectGetHeight(self.scrollView.frame));
        [self.scrollView setAlpha:0.2];
        
    } completion:^(BOOL finished) {
        //执行完后走这里的代码块
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
