//
//  WRFilterViewController.h
//  mac15wr
//
//  Created by Alex on 2/27/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WRFilterViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *termPickView;
@property (weak, nonatomic) IBOutlet UIPickerView *deptPickView;

@property (weak, nonatomic) IBOutlet UIPickerView *classTypePickView;
@property (weak, nonatomic) IBOutlet UIPickerView *professorRatingPickView;
@property (weak, nonatomic) IBOutlet UIPickerView *courseRatingPickView;
@property (weak, nonatomic) IBOutlet UIPickerView *dayOfClassPickView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *submitFilterConditionButton;

@end
