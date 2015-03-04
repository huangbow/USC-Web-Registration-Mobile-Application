//
//  RightViewController.h
//  mac15wr
//
//  Created by zwein on 2/14/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WRFiveViewController.h"
#import "CenterViewController.h"
#import "WishListTableView.h"
#import "CheckListTableView.h"

@interface RightViewController : WRFiveViewController

@property (strong, nonatomic) CenterViewController *centerViewControllerDelegate;

@property (nonatomic, strong) WishListTableView *wishlistTable;
@property (nonatomic, strong) NSMutableArray *wishlistContent;

@property (nonatomic, strong) CheckListTableView *checkoutTable;
@property (nonatomic, strong) NSMutableArray *checkoutContent;

-(void) openWishListView;
-(void) openCheckListView;

-(void) presentViewContent;
-(void) hideViewContent;

@end
