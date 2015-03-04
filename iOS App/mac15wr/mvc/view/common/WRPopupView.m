//
//  WRPopupView.m
//  mac15wr
//
//  Created by zwein on 2/25/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import "WRPopupView.h"

@implementation WRPopupView

-(id) init{
    
    self = [super init];
    CGFloat cornerRadius = 12.f;
    CGFloat contentSize = 150.f;
    self.backgroundColor = [UIColor clearColor];
    self.layer.cornerRadius = cornerRadius;
    
    
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.backgroundColor = [UIColor WR_USC_Red];
    _titleLabel.clipsToBounds = YES;
    //    _titleLabel.layer.cornerRadius = cornerRadius;
    _titleLabel.textColor = [UIColor WR_USC_Yellow];
    _titleLabel.font = [UIFont boldSystemFontOfSize:24.0];
    _titleLabel.text = @"Hello";
    _titleLabel.frame = CGRectMake(0, 0, SCREEN_WIDTH-55, 50);
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    UIRectCorner corner = UIRectCornerTopLeft|UIRectCornerTopRight;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_titleLabel.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(20, 20)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = _titleLabel.bounds;
    maskLayer.path = maskPath.CGPath;
    _titleLabel.layer.mask = maskLayer;
    
    [self addSubview:_titleLabel];
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor WR_USC_Yellow];
    _contentView.frame = CGRectMake(0, CGRectGetHeight(_titleLabel.frame), SCREEN_WIDTH-55, contentSize);
    [self addSubview:_contentView];
    
//    [[UIColor WR_USC_Yellow] set];
    _dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _dismissButton.contentEdgeInsets = UIEdgeInsetsMake(10, 20, 10, 20);
    _dismissButton.backgroundColor = [UIColor WR_USC_Red];
    [_dismissButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_dismissButton setTitleColor:[[_dismissButton titleColorForState:UIControlStateNormal] colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
    _dismissButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
    [_dismissButton setTitle:@"Close" forState:UIControlStateNormal];
    //    _dismissButton.layer.cornerRadius = cornerRadius;
    [_dismissButton addTarget:self action:@selector(dismissButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    _dismissButton.frame = CGRectMake(0, CGRectGetHeight(_titleLabel.frame) + CGRectGetHeight(_contentView.frame), SCREEN_WIDTH-55, 40);
    
    UIRectCorner cornerdis = UIRectCornerBottomLeft|UIRectCornerBottomRight;
    UIBezierPath *maskPathdis = [UIBezierPath bezierPathWithRoundedRect:_dismissButton.bounds byRoundingCorners:cornerdis cornerRadii:CGSizeMake(20, 20)];
    CAShapeLayer *maskLayerdis = [CAShapeLayer layer];
    maskLayerdis.frame = _dismissButton.bounds;
    maskLayerdis.path = maskPathdis.CGPath;
    _dismissButton.layer.mask = maskLayerdis;
    [self addSubview:_dismissButton];
    
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH-55,  CGRectGetHeight(_titleLabel.frame) +
                            CGRectGetHeight(_contentView.frame) + CGRectGetHeight(_dismissButton.frame));
    
    
    
    
    return self;

}


- (void)dismissButtonPressed:(id)sender {
    if ([sender isKindOfClass:[UIView class]]) {
        [(UIView*)sender dismissPresentingPopup];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
