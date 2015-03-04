//
//  WRSectionTableViewCell.h
//  mac15wr
//
//  Created by Alex on 2/26/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WRSectionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *courseTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *classNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *srwLabel;
@property (weak, nonatomic) IBOutlet UILabel *hoursLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *roomLabel;
@property (weak, nonatomic) IBOutlet UILabel *instractorLabel;
@property (weak, nonatomic) IBOutlet UIButton *a2wlButton;
@property (weak, nonatomic) IBOutlet UIButton *a2bButton;


@end
