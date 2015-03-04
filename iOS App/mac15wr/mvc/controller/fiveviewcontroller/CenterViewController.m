//
//  CenterViewController.m
//  mac15wr
//
//  Created by zwein on 2/14/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import "CenterViewController.h"
#import "VBPieChart.h"
#import "WRProcessCheckView.h"
#import "KVNMaskedPageControl.h"
#import "WRPayDueView.h"
#import "WRReminderView.h"


@interface CenterViewController ()


@property (nonatomic, retain) VBPieChart *chart;
@property (nonatomic, retain) NSArray *chartValues;
@property (nonatomic, retain) CKRadialMenu *radialView;

@end

@implementation CenterViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    self.deckCP = IIViewDeckCenterCP;
    
    
    // load main circle
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat circleRadius = (screenWidth-80)/2;
    self.circleProgressView = [[CircleProgressView alloc] init];
    self.circleProgressView.frame = CGRectMake(0, 0, circleRadius*2, circleRadius*2);
    self.circleProgressView.center = CGPointMake(screenWidth/2, screenHeight/2);
    self.circleProgressView.status = @"Registering";
    self.circleProgressView.registeredPoint = @"9 Point Registered";
    self.circleProgressView.requiredPoint = @"8 Point Required";
    [self.circleProgressView setTimeLimit:20];
    [self.circleProgressView setElapsedTime:17];
    [self.view addSubview:self.circleProgressView];
    
    
    // load widgets
//    UILabel *label = [[UILabel alloc] init];
//    label.text = @"34/35";
//    label.textColor = [UIColor whiteColor];
//    label.frame = CGRectMake(0, -10, 300, 100);
//    [self.view addSubview:label];

    
//    self.overallCircleProcessView = [[OverallCircleProgressView alloc] initWithFrame:CGRectMake(self.view.center.x, self.view.center.y, 40, 40)];
//    self.overallCircleProcessView.center = CGPointMake(screenWidth-40, screenHeight/2-circleRadius-20);
//    [self.view addSubview:self.overallCircleProcessView];
//    [self.overallCircleProcessView update:50];
//    
//    [self.overallCircleProcessView whenTapped:^{
//        OverallViewController *overallViewController = [[OverallViewController alloc] init];
//        overallViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//        overallViewController.modalPresentationStyle = UIModalPresentationFullScreen;
//        
//        
//        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:overallViewController] animated:YES completion:^{
//            NSLog(@"aaa");
//        }];
//    }];
//    
    
    if (!_chart) {
        _chart = [[VBPieChart alloc] init];
        self.view.backgroundColor = [UIColor blackColor];
        [self.view addSubview:_chart];
    }
    
//    [_chart setFrame:CGRectMake(10, 50, 300, 300)];
    [_chart setFrame:CGRectMake(0, 0, circleRadius*2, circleRadius*2)];

    [_chart setEnableStrokeColor:NO];
    [_chart setHoleRadiusPrecent:0.8];
    [_chart setStartAngle:-M_PI/2];
    [_chart setStrokeColor:[UIColor whiteColor]];
    [_chart setEnableInteractive:NO];
    [_chart setRadiusPrecent:0.92];
    [_chart setAlpha:0.85];
    
    _chart.center = CGPointMake(screenWidth/2, screenHeight/2);
    self.chartValues = @[
                         @{@"name":@"first", @"value":@20, @"color":[UIColor nephritisColor]},
                         @{@"name":@"second", @"value":@60, @"color":[UIColor belizeHoleColor]},
                         @{@"name":@"third", @"value":@60, @"color":[UIColor WR_USC_Yellow]},
                         @{@"name":@"fourth", @"value":@60, @"color":[UIColor WR_USC_Red]},
                         @{@"name":@"fifth", @"value":@20, @"color":[UIColor wetAsphaltColor]},
                         ];
    _chart.delegate = self;
    [_chart setChartValues:_chartValues animation:YES];
    [_chart setChartValues:_chartValues animation:YES duration:0.5f options:VBPieChartAnimationFan|VBPieChartAnimationTimingEaseInOut];
    
//    [_chart addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(middleCircleClicked)]];
    
    
    // due button
    CGFloat popCircleRadius = 25.0;
    self.radialView = [[CKRadialMenu alloc] initWithFrame:CGRectMake(0, 0, popCircleRadius, popCircleRadius)];
    self.radialView.delegate = self;
    self.radialView.center = CGPointMake(screenWidth/2, screenHeight/2);
    self.radialView.centerView.backgroundColor = [UIColor clearColor];
    self.radialView.centerView.alpha = 0;
    self.radialView.distanceFromCenter = circleRadius+25;
    self.radialView.startAngle = -M_PI/2;

    [self.radialView addPopoutView:nil withIndentifier:@"ONE"];
    [self.radialView addPopoutView:nil withIndentifier:@"TWO"];
    [self.radialView addPopoutView:nil withIndentifier:@"THREE"];
    [self.radialView addPopoutView:nil withIndentifier:@"FOUR"];
    [self.radialView addPopoutView:nil withIndentifier:@"FIVE"];
    self.radialView.distanceBetweenPopouts = 360/[self.radialView.popoutViews count];

    self.radialView.animationDuration = 0.0;
    [self.radialView expand];
    [self.view addSubview:self.radialView];
    
    
    // TopViewController Page Control
    self.pageControl = [[KVNMaskedPageControl alloc] init];
    [self.pageControl setCenter:CGPointMake(SCREEN_WIDTH/2, 30)];
    //[self.pageControl setHidesForSinglePage:YES];
    [self.view addSubview:self.pageControl];
    
    
    
    // Wish List Box
    _wishlistBadge = [[M13BadgeView alloc] initWithFrame: CGRectMake(0, 0, 12, 20)];
    _wishlistBadge.text = @"7";
    _wishlistBadge.textColor = [UIColor nephritisColor];
    _wishlistBadge.badgeBackgroundColor = [UIColor midnightBlueColor];
    _wishlistBox = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 + circleRadius, SCREEN_HEIGHT/2 - circleRadius-20, 32, 32)];
    [_wishlistBox setBackgroundColor:
     [UIColor colorWithPatternImage:[UIImage imageNamed:@"wishlistbox.png"]]];
    [_wishlistBox addSubview:_wishlistBadge];
//    [_wishlistBox addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wishlistBoxClicked)]];
    [self.view addSubview:_wishlistBox];

    // Check List Box
    _checklistBadge = [[M13BadgeView alloc] initWithFrame: CGRectMake(0, 0, 12, 20)];
    _checklistBadge.text = @"2";
    _checklistBadge.textColor = [UIColor nephritisColor];
    _checklistBadge.badgeBackgroundColor = [UIColor midnightBlueColor];
    _checklistBox = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 + circleRadius, SCREEN_HEIGHT/2 + circleRadius, 32, 32)];
    [_checklistBox setBackgroundColor:
     [UIColor colorWithPatternImage:[UIImage imageNamed:@"checklistbox.png"]]];
    [_checklistBox addSubview:_checklistBadge];
//    [_wishlistBox addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checklistBoxClicked)]];
    [self.view addSubview:_checklistBox];
    
    
    // Check List Box
    _reminderBadge = [[M13BadgeView alloc] initWithFrame: CGRectMake(0, 0, 12, 20)];
    _reminderBadge.text = @"1";
    _reminderBadge.textColor = [UIColor nephritisColor];
    _reminderBadge.badgeBackgroundColor = [UIColor midnightBlueColor];
    _reminderBox = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - circleRadius-20, SCREEN_HEIGHT/2 + circleRadius+3, 32, 32)];
    [_reminderBox setBackgroundColor:
     [UIColor colorWithPatternImage:[UIImage imageNamed:@"reminder"]]];
    [_reminderBox addSubview:_reminderBadge];
    [_reminderBox addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reminderBoxClicked)]];
    [self.view addSubview:_reminderBox];
    
    
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
-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionDown) {
        if ([self.viewDeckController isSideClosed:IIViewDeckTopSide]&&
            [self.viewDeckController isSideClosed:IIViewDeckBottomSide]) {
            [self.viewDeckController openTopView];
        } else if ([self.viewDeckController isSideOpen:IIViewDeckBottomSide]&&
                   [self.viewDeckController isSideClosed:IIViewDeckTopSide]){
            [self.viewDeckController closeOpenView];
        } else {
            
        }
        
        
        //NSLog(@"swipe down");
    }
    if(recognizer.direction==UISwipeGestureRecognizerDirectionUp) {
        if ([self.viewDeckController isSideClosed:IIViewDeckTopSide]&&
            [self.viewDeckController isSideClosed:IIViewDeckBottomSide]) {
            [self.viewDeckController openBottomView];
        } else if ([self.viewDeckController isSideOpen:IIViewDeckTopSide]&&
                   [self.viewDeckController isSideClosed:IIViewDeckBottomSide]){
            [self.viewDeckController closeOpenView];
        } else {
            
        }
        //NSLog(@"swipe up");
    }
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft) {
        if ([self.viewDeckController isSideClosed:IIViewDeckLeftSide]&&
            [self.viewDeckController isSideClosed:IIViewDeckRightSide]) {
            [self.viewDeckController openRightView];
        } else if ([self.viewDeckController isSideOpen:IIViewDeckLeftSide]&&
                   [self.viewDeckController isSideClosed:IIViewDeckRightSide]){
            [self.viewDeckController closeOpenView];
        } else {
            
        }
        //NSLog(@"swipe left");
    }
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionRight) {
        if ([self.viewDeckController isSideClosed:IIViewDeckLeftSide]&&
            [self.viewDeckController isSideClosed:IIViewDeckRightSide]) {
            [self.viewDeckController openLeftView];
        } else if ([self.viewDeckController isSideOpen:IIViewDeckRightSide]&&
                   [self.viewDeckController isSideClosed:IIViewDeckLeftSide]){
            [self.viewDeckController closeOpenView];
        } else {
            
        }
        //NSLog(@"swipe right");
    }
    
}



/**
 *  Handle Pie Touched Event here
 *
 *  @param touchedPieName <#touchedPieName description#>
 */
-(void) handlePieTouchedEvent:(NSString*) touchedPieName{
//    if ([touchedPieName isEqualToString:@"first"]) {
//        NSLog(@"1");
    WRProcessCheckView *processCheckView = [[WRProcessCheckView alloc] initWithCVType:touchedPieName];
//        processCheckView.backgroundColor = [UIColor orangeColor];
//        processCheckView.frame = CGRectMake(0.0, 0.0, 100.0, 100.0);
        processCheckView.parentControllerDelegate = self;
        //processCheckView.cvTypeString = touchedPieName;
        KLCPopup* popup = [KLCPopup popupWithContentView:processCheckView
                                                showType:KLCPopupShowTypeBounceInFromTop
                                             dismissType:KLCPopupDismissTypeBounceOutToBottom
                                                maskType:KLCPopupMaskTypeDimmed
                                dismissOnBackgroundTouch:YES
                                   dismissOnContentTouch:NO];
        processCheckView.klcPopupDelegate = popup;
        [popup show];
        
//        
//    } else if ([touchedPieName isEqualToString:@"second"]) {
//        NSLog(@"2");
//
//    } else if ([touchedPieName isEqualToString:@"third"]) {
//        NSLog(@"3");
//
//    } else if ([touchedPieName isEqualToString:@"fourth"]) {
//        NSLog(@"4");
//
//    } else if ([touchedPieName isEqualToString:@"fifth"]) {
//        NSLog(@"5");
//
//    }
}

-(void)radialMenu:(CKRadialMenu *)radialMenu didSelectPopoutWithIndentifier:(NSString *)identifier{
    NSLog(@"Delegate notified of press on popout \"%@\"", identifier);
    WRPayDueView *paydueView = [[WRPayDueView alloc] initWithPayDueNo:identifier];
    paydueView.parentControllerDelegate = self;
    paydueView.titleLabel.text = @"Pay Due Warning";

    if ([identifier isEqualToString:@"ONE"]) {
        paydueView.contentText.text = @" Next Due date is on Jan 4\n You need pay the course you had registered before the due date\n Late fee: 100$";
    } else if ([identifier isEqualToString:@"TWO"]) {
        paydueView.contentText.text = @" Next Due date is on Jan 11\n You need pay the course you had registered before the due date\n Late fee: 100$";
    } else if ([identifier isEqualToString:@"THREE"]) {
        paydueView.contentText.text = @" Next Due date is on Jan 18\n You need pay the course you had registered before the due date\n Late fee: 100$";
    } else if ([identifier isEqualToString:@"FOUR"]) {
        paydueView.contentText.text = @" Next Due date is on Jan 25\n You need pay the course you had registered before the due date\n Late fee: 100$";
    } else if ([identifier isEqualToString:@"FIVE"]) {
        paydueView.contentText.text = @" Next Due date is on Feb 1\n You need pay the course you had registered before the due date\n Late fee: 100$";
    }
    
    
    KLCPopup* popup = [KLCPopup popupWithContentView:paydueView
                                            showType:KLCPopupShowTypeBounceInFromTop
                                         dismissType:KLCPopupDismissTypeBounceOutToBottom
                                            maskType:KLCPopupMaskTypeDimmed
                            dismissOnBackgroundTouch:YES
                               dismissOnContentTouch:NO];
    paydueView.klcPopupDelegate = popup;
    [popup show];
}

-(void)middleCircleClicked{
    NSLog(@"ss");
}

-(void) reminderBoxClicked{
    WRReminderView *reminderView = [[WRReminderView alloc] init];
    //        processCheckView.backgroundColor = [UIColor orangeColor];
    //        processCheckView.frame = CGRectMake(0.0, 0.0, 100.0, 100.0);
    reminderView.parentControllerDelegate = self;
    //processCheckView.cvTypeString = touchedPieName;
    KLCPopup* popup = [KLCPopup popupWithContentView:reminderView
                                            showType:KLCPopupShowTypeBounceInFromTop
                                         dismissType:KLCPopupDismissTypeBounceOutToBottom
                                            maskType:KLCPopupMaskTypeDimmed
                            dismissOnBackgroundTouch:YES
                               dismissOnContentTouch:NO];
    reminderView.klcPopupDelegate = popup;
    [popup show];
}



@end
