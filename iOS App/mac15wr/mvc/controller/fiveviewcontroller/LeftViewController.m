//
//  LeftViewController.m
//  mac15wr
//
//  Created by zwein on 2/14/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import "LeftViewController.h"


#define BG_OFFSET SCREEN_WIDTH-80

@interface LeftViewController (){
    CGPoint contentCenter;
}

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = [UIColor pomegranateColor];
    self.contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH - 80, SCREEN_HEIGHT-80);
    contentCenter =  CGPointMake(0, SCREEN_HEIGHT/2);
    self.contentView.alpha = 0.3;
    self.contentView.center = CGPointMake(contentCenter.x - BG_OFFSET, contentCenter.y);


    
    UILabel *lbl1 = [[UILabel alloc] init];
    lbl1.frame = CGRectMake(0, 200, 300, 100);
//    lbl1.center = CGPointMake(CGRectGetWidth(self.contentView.frame)/2, CGRectGetHeight(self.contentView.frame)/2);
    lbl1.text = @"Student Profile";
    lbl1.textColor = [UIColor WR_USC_Yellow];
    lbl1.font = [UIFont boldSystemFontOfSize:24.f];
    
    [self.contentView addSubview:lbl1];
    
    UILabel *lbl2 = [[UILabel alloc] init];
    lbl2.frame = CGRectMake(0, 240, 300, 100);
//    lbl2.center = CGPointMake(CGRectGetWidth(self.contentView.frame)/2, CGRectGetHeight(self.contentView.frame)/2);
    lbl2.text = @"Preferences";
    lbl2.textColor = [UIColor WR_USC_Yellow];
    lbl2.font = [UIFont boldSystemFontOfSize:24.f];
    [self.contentView addSubview:lbl2];
    
    UILabel *lbl3 = [[UILabel alloc] init];
    lbl3.frame = CGRectMake(0, 280, 300, 100);
//    lbl3.center = CGPointMake(CGRectGetWidth(self.contentView.frame)/2, CGRectGetHeight(self.contentView.frame)/2);
    lbl3.text = @"System Setting";
    lbl3.textColor = [UIColor WR_USC_Yellow];
    lbl3.font = [UIFont boldSystemFontOfSize:24.f];
    [self.contentView addSubview:lbl3];
    
    [self.view addSubview:self.contentView];
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

-(void) presentViewContent{
    
//    UIViewAnimationOptions uioptions = UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionBeginFromCurrentState;
//    options |= [self isSideOpen:side] ? UIViewAnimationOptionCurveEaseInOut : UIViewAnimationOptionCurveEaseOut;
  
//    [UIView beginAnimations:@"ChangeAlphaAnimation" context:NULL];
//    [UIView setAnimationDuration:2.0];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [self.contentView setAlpha:0.2];
//    [UIView setAnimationDelegate:self];
//    //[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
//    [UIView commitAnimations];
    
    [UIView animateWithDuration:FIVEPAGE_TRANSITION_DURATION animations:^{
        //[UIView setAnimationDelay:1.2];//配置动画时延
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.contentView.center = CGPointMake(CGRectGetMidX([[UIScreen mainScreen] bounds]), CGRectGetMidY([[UIScreen mainScreen] bounds]));
        [self.contentView setAlpha:1.0];
        //self.contentView.center = CGPointMake(0,0);//可以对多个view进行我们想要的动画配置
        //newView.center = CGPointMake(X,Y);
        
    } completion:^(BOOL finished) {
        //执行完后走这里的代码块
    }];

}


-(void) hideViewContent{
    [UIView animateWithDuration:FIVEPAGE_TRANSITION_DURATION animations:^{
        //[UIView setAnimationDelay:1.2];//配置动画时延
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.contentView.center = CGPointMake(-CGRectGetMidX([[UIScreen mainScreen] bounds]), CGRectGetMidY([[UIScreen mainScreen] bounds]));
        [self.contentView setAlpha:0.2];
        //self.contentView.center = CGPointMake(0,0);//可以对多个view进行我们想要的动画配置
        //newView.center = CGPointMake(X,Y);
        
    } completion:^(BOOL finished) {
        //执行完后走这里的代码块
    }];
}





@end
