//
//  AppDelegate.h
//  mac15wr
//
//  Created by zwein on 15/2/7.
//  Copyright (c) 2015年 mac15wr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GooglePlus/GooglePlus.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,GPPSignInDelegate>

@property (strong, nonatomic) UIWindow *window;

-(void)entermainpage;

@end

