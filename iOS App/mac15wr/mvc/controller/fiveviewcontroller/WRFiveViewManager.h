//
//  WRFiveViewManager.h
//  mac15wr
//
//  Created by zwein on 2/14/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CenterViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "TopViewController.h"
#import "BottomViewController.h"


@interface WRFiveViewManager : NSObject<IIViewDeckControllerDelegate>
@property (strong, nonatomic) CenterViewController *centerViewController;
@property (strong, nonatomic) LeftViewController *leftViewController;
@property (strong, nonatomic) RightViewController *rightViewController;
@property (strong, nonatomic) TopViewController *topViewController;
@property (strong, nonatomic) BottomViewController *bottomViewController;
@property (strong, nonatomic) IIViewDeckController *deckViewController;

@property (strong, nonatomic) NSArray *fiveVewControllers;

+ (WRFiveViewManager *)sharedInstance;
- (IIViewDeckController*) getDeckController;
- (void)setBgColor:(UIColor*) bgColor;


@end
