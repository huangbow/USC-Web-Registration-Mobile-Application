//
//  UIView+WRView.m
//  mac15wr
//
//  Created by zwein on 2/25/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import "UIView+WRView.h"

@implementation UIView (WRView)

+ (void)cornerview:(UIView*)view corner:(UIRectCorner)uirc cornerRadii:(CGSize)cr{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:uirc cornerRadii:cr];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
