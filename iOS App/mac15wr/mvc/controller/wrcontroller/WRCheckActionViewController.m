//
//  WRCheckActionViewController.m
//  mac15wr
//
//  Created by zwein on 2/22/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import "WRCheckActionViewController.h"

@interface WRCheckActionViewController ()

@end

@implementation WRCheckActionViewController
@synthesize headerContainer;
@synthesize titleLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithIntegerRed:250. green:259. blue:242 alpha:1.];
    
    // Header Container
    headerContainer = [[UIView alloc] init];
    headerContainer.backgroundColor = [UIColor WR_USC_Red];
    [self.view addSubview:headerContainer];
    
    
    UIImage *image = [UIImage imageNamed:@"nbi_close"];
    CGRect frame = CGRectMake(SCREEN_WIDTH-image.size.width-10, 10, image.size.width, image.size.height);
    UIButton* button = [[UIButton alloc] initWithFrame:frame];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setShowsTouchWhenHighlighted:YES];
    [button addTarget:self action:@selector(closeButtonPressed) forControlEvents:UIControlEventTouchDown];
    [headerContainer addSubview:button];
    headerContainer.frame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(button.frame) + 20);
    button.center = CGPointMake(button.center.x, CGRectGetHeight(headerContainer.frame)/2);
    
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.frame  = CGRectMake(0, 0, SCREEN_WIDTH/2, CGRectGetHeight(headerContainer.frame));
    titleLabel.center = CGPointMake(CGRectGetWidth(headerContainer.frame)/2, CGRectGetHeight(headerContainer.frame)/2);
    titleLabel.text = @"Title";
    titleLabel.textColor = [UIColor WR_USC_Yellow];
    titleLabel.font = [UIFont boldSystemFontOfSize:28.f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [headerContainer addSubview:titleLabel];
    
    
    
}


-(void) closeButtonPressed{
    NSLog(@"close");
//    CATransition* transition = [CATransition animation];
//    transition.duration = 0.3;
//    transition.type = kCATransitionReveal;
//    transition.subtype = kCATransitionFromLeft;
//    [self.parentViewController.navigationController.view.layer addAnimation:transition forKey:kCATransition];
//    [self.parentViewController.navigationController popViewControllerAnimated:NO];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [self.view.window.layer addAnimation:transition forKey:nil];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
