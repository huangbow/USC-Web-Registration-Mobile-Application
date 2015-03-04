//
//  WRPayDueView.h
//  mac15wr
//
//  Created by zwein on 2/25/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "KLCPopup.h"

@interface WRPayDueView : UIView



@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UITextView *contentText;

@property (nonatomic, strong) UIButton* dismissButton;
@property (nonatomic, strong) UIViewController *parentControllerDelegate;
@property (nonatomic, strong) KLCPopup *klcPopupDelegate;
@property (nonatomic, strong) NSString *pdNoString;



- (id) initWithPayDueNo:(NSString*)pdNoString;


@end
