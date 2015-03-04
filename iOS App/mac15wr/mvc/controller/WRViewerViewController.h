//
//  WRViewerViewController.h
//  mac15wr
//
//  Created by zwein on 2/26/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WRCheckActionViewController.h"
#import "FTCoreTextView.h"

@interface WRViewerViewController : WRCheckActionViewController
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) FTCoreTextView* textView;
@property (nonatomic, strong) NSString* textResourceString;

-(id)initWithTextResource:(NSString*) resName;
@end
