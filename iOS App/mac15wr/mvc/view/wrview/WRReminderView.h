//
//  WRReminderView.h
//  mac15wr
//
//  Created by zwein on 2/26/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import <UIKit/UIKit.h>

#include "KLCPopup.h"
#include "CenterViewController.h"

@interface WRReminderView : UIView<UITableViewDataSource,
UITableViewDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton* dismissButton;
//@property (nonatomic, strong) UILabel *descLabel;

@property (nonatomic, strong) UITableView *checklistTable;
@property (nonatomic, strong) NSMutableArray *checklistContent;

@property (nonatomic, strong) CenterViewController *parentControllerDelegate;
@property (nonatomic, strong) KLCPopup *klcPopupDelegate;

@property (nonatomic, strong) NSString *cvTypeString;

@end
