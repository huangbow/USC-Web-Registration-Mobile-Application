//
//  WRReminderView.m
//  mac15wr
//
//  Created by zwein on 2/26/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import "WRReminderView.h"

@implementation WRReminderView



-(id) init{
    self = [super init];
    //self.translatesAutoresizingMaskIntoConstraints = NO;
    self.backgroundColor = [UIColor WR_USC_Red];//[UIColor colorWithIntegerRed:213 green:76 blue:60 alpha:0.9];
    self.layer.cornerRadius = 12.0;
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH-55, SCREEN_WIDTH-55);
    self.cvTypeString = @"first";
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.clipsToBounds = YES;
    _titleLabel.layer.cornerRadius = 6.0;
    _titleLabel.textColor = [UIColor WR_USC_Yellow];
    _titleLabel.font = [UIFont boldSystemFontOfSize:24.0];
    _titleLabel.text = @"Reminder";
    _titleLabel.frame = CGRectMake(0, 0, SCREEN_WIDTH-55, 50);
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
    
    
    _dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _dismissButton.contentEdgeInsets = UIEdgeInsetsMake(10, 20, 10, 20);
    _dismissButton.backgroundColor = [UIColor WR_USC_Red];
    [_dismissButton setTitleColor:[UIColor WR_USC_Yellow] forState:UIControlStateNormal];
    [_dismissButton setTitleColor:[[_dismissButton titleColorForState:UIControlStateNormal] colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
    _dismissButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
    [_dismissButton setTitle:@"Close" forState:UIControlStateNormal];
    _dismissButton.layer.cornerRadius = 6.0;
    [_dismissButton addTarget:self action:@selector(dismissButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    _dismissButton.frame = CGRectMake(0, SCREEN_WIDTH-95, SCREEN_WIDTH-55, 40);
    [self addSubview:_dismissButton];
    
    
    // Data Source
    _checklistContent = [[NSMutableArray alloc] init];
    
    [_checklistContent addObjectsFromArray:[[NSArray alloc] initWithObjects:
                                                @"1. Late Fee Warning",
                                                @"2. Registration will be closed",
                                                nil]];
    
    
    // Data Table
    _checklistTable = [[UITableView alloc] init];
    _checklistTable.frame = CGRectMake(0, 50, SCREEN_WIDTH-55, SCREEN_WIDTH-145);
    _checklistTable.separatorColor = [UIColor clearColor];
    _checklistTable.alpha = 0.9;
    _checklistTable.backgroundColor = [UIColor WR_USC_Yellow];
    _checklistTable.delegate = self;
    _checklistTable.dataSource = self;
    //_checklistTable.dataSource = _checklistContent;
    [self addSubview:_checklistTable];
    
    return self;
}



- (void)dismissButtonPressed:(id)sender {
    if ([sender isKindOfClass:[UIView class]]) {
        [(UIView*)sender dismissPresentingPopup];
    }
}


#pragma mark - Table View Data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
(NSInteger)section{
    return [self.checklistContent count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"WRChecklistContent";
    
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
    //                             cellIdentifier];
    //    if (cell == nil) {
    //        cell = [[UITableViewCell alloc]initWithStyle:
    //                UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    //        cell.textLabel.textColor = [UIColor cloudsColor];
    //        cell.backgroundColor = [UIColor alizarinColor];
    //        cell.textLabel.font = [UIFont boldSystemFontOfSize:20.0];
    //
    //    }
    TDBadgedCell *cell =[[TDBadgedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    cell.textLabel.textColor = [UIColor WR_USC_Red];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
    cell.backgroundColor = [UIColor WR_USC_Yellow];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.frame = CGRectMake(0, 0, CGRectGetWidth(cell.frame), CGRectGetHeight(cell.frame));
    bgColorView.backgroundColor = [UIColor alizarinColor];
    [cell setSelectedBackgroundView:bgColorView];
    cell.badgeString = @"unread";
    cell.badgeColor = [UIColor WR_USC_Red];
    cell.badgeTextColor = [UIColor WR_USC_Yellow];
    //cell.badge.radius = 9;
    cell.badge.fontSize = 13;
    cell.badge.boldFont = YES;
    cell.badge.layer.borderWidth = 0;
    cell.badge.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
    
    
    NSString *stringForCell = [self.checklistContent objectAtIndex:indexPath.row];
    //NSLog(@"%@", stringForCell);
    [cell.textLabel setText:stringForCell];
    return cell;
}

// Default is 1 if not implemented
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:
//(NSInteger)section{
//    NSString *headerTitle;
//    if (section==0) {
//        headerTitle = @"Section 1 Header";
//    }
//    else{
//        headerTitle = @"Section 2 Header";
//
//    }
//    return headerTitle;
//}
//
//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:
//(NSInteger)section{
//    NSString *footerTitle;
//    if (section==0) {
//        footerTitle = @"Section 1 Footer";
//    }
//    else{
//        footerTitle = @"Section 2 Footer";
//
//    }
//    return footerTitle;
//}


#pragma mark - TableView delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
(NSIndexPath *)indexPath{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    [self handleCheckViewAction: indexPath.row];
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
