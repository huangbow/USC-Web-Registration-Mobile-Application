//
//  UIView+WRView.h
//  mac15wr
//
//  Created by zwein on 2/25/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WRView)

+ (void)cornerview:(UIView*)view corner:(UIRectCorner)corner cornerRadii:(CGSize)cornerRadii;

@end
