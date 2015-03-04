//
//  AppDelegate.m
//  mac15wr
//
//  Created by zwein on 15/2/7.
//  Copyright (c) 2015年 mac15wr. All rights reserved.
//

#import "AppDelegate.h"
#import <GooglePlus/GooglePlus.h>
#import <GoogleOpenSource/GoogleOpenSource.h>
#import "WRFiveViewManager.h"
#import "SRFSurfboard.h"
#import "WRRealmUsers.h"
#import "WRLoginViewController.h"
#import "WRCourse.h"



@interface AppDelegate ()<SRFSurfboardDelegate>
@property GPPSignIn *signIn;
@end


@implementation AppDelegate

// Please use the client ID created for you by Google.
static NSString * const kClientID =
@"505486916113-8mdlode4utlqdoq7vr83l0ric7g5h6r9.apps.googleusercontent.com";


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // Override point for customization after application launch.
    [[UIApplication sharedApplication] setStatusBarHidden: YES];
    
    WRLOG_INIT  //  Initial Log Method
    //    DDLogVerbose(@"Verbose");
    //    DDLogDebug(@"Debug");
    //    DDLogInfo(@"Info");
    //    DDLogWarn(@"Warn");
    //    DDLogError(@"Error");
    
    
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    WRFiveViewManager *wrFiveViewManager = [WRFiveViewManager sharedInstance];
//    [wrFiveViewManager setBgColor:[UIColor pomegranateColor]];
//    IIViewDeckController *deckViewController = [wrFiveViewManager getDeckController];
//    self.window.rootViewController = deckViewController;
//    self.window.backgroundColor = [UIColor whiteColor];
//    [self.window makeKeyAndVisible];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"panels" ofType:@"json"];
    NSArray *panels = [SRFSurfboardViewController panelsFromConfigurationAtPath:path];
    SRFSurfboardViewController *surfboard = [[SRFSurfboardViewController alloc] initWithPathToConfiguration:path];
    [surfboard setPanels:panels];
    surfboard.delegate = self;
    surfboard.backgroundColor = [UIColor WR_USC_Yellow];

    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = surfboard;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    //google+ login
    GPPSignIn *signin=[GPPSignIn sharedInstance];
    signin.clientID=kClientID;
    signin.scopes=@[kGTLAuthScopePlusLogin];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [GPPURLHandler handleURL:url
                  sourceApplication:sourceApplication
                         annotation:annotation];
}

#pragma mark - GPPDeepLinkDelegate

- (void)didReceiveDeepLink:(GPPDeepLink *)deepLink {
    // An example to handle the deep link data.
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Deep-link Data"
                          message:[deepLink deepLinkID]
                          delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [alert show];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/**
 *  Handle SRFSurfboardView Action
 */
- (void)surfboard:(SRFSurfboardViewController *)surfboard didTapButtonAtIndexPath:(NSIndexPath *)indexPath
{
    //        WRFiveViewManager *wrFiveViewManager = [WRFiveViewManager sharedInstance];
    //        [wrFiveViewManager setBgColor:[UIColor pomegranateColor]];
    //        IIViewDeckController *deckViewController = [wrFiveViewManager getDeckController];
    //        self.window.rootViewController = deckViewController;
//    //fetch data from back-end
    
    RLMRealm *realm=[RLMRealm defaultRealm];
    NSString *courseString=[WRFetchData
                            searchCourseByCoditions:[WRFetchData
                                                     stringOfCourseSerchConditonsWithCourseRating:@"3" ProfRating:@"3"
                                                     Day:nil
                                                     TimeStart:nil
                                                     TimeEnd:nil
                                                     TimeTypeAsInclude:@""]
                            Term:@"20151"
                            Dept:@"CSCI"];
    [[WRAPIClient sharedClient] GET:courseString parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSMutableArray* mutableCourses = [NSMutableArray arrayWithCapacity:[JSON count]];
        [realm beginWriteTransaction];
        
        
        for (NSDictionary *course_attributes in JSON) {
            WRCourse *course = [[WRCourse alloc] initWithAttributes:course_attributes];
            
            if ([WRRealmCourse objectsWhere:@"sis_course_id=%@",course.sis_course_id].count) {
                continue;
            }
            
            
            WRRealmCourse *newcourse=[[WRRealmCourse alloc] init];
            newcourse.course_id=course.course_id;
            newcourse.sis_course_id=course.sis_course_id;
            newcourse.title=course.title;
            newcourse.min_units=course.min_units;
            newcourse.max_units=course.max_units;
            newcourse.total_max_units=course.total_max_units;
            newcourse.desc=course.desc;
            newcourse.diversity_flag=course.diversity_flag;
            newcourse.effective_term_code=course.effective_term_code;
            newcourse.section=[NSKeyedArchiver archivedDataWithRootObject:course.section];
            [realm addObject:newcourse];
            [mutableCourses addObject:course];
        }
        
        
        [realm commitWriteTransaction];
        
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        
    }];
    
//    NSString* schoolliststring=[WRFetchData getSchoolList];
//    [[WRAPIClient sharedClient] GET:schoolliststring parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
//        [realm beginWriteTransaction];
//        
//        
//        for (NSDictionary *course_attributes in JSON) {
//            WRSchoolList *schoollist = [[WRSchoolList alloc] initWithAttributes:course_attributes];
//            
//            for (NSString* schoolname in schoollist.schoolList) {
//                WRRealmSchoolList* sch=[[WRRealmSchoolList alloc] init];
//                sch.schoolAbb=schoolname;
//                [realm addObject:sch];
//            }
//            
//            
//        }
//        
//        
//        [realm commitWriteTransaction];
//        
//    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
//        
//    }];
    
    
    
    
    
    
    
    //google login
    //ONLY work when user already logined in
    //now disable it,and just go to the next view straightly
    //-----------------------------------------------------------------------------
    self.signIn = [GPPSignIn sharedInstance];
    self.signIn.shouldFetchGooglePlusUser = YES;
    self.signIn.shouldFetchGoogleUserID=YES;
    self.signIn.shouldFetchGoogleUserEmail = YES;  // Uncomment to get the user's email
    
    
    // You previously set kClientId in the "Initialize the Google+ client" step
    self.signIn.clientID = kClientID;
    
    // Uncomment one of these two statements for the scope you chose in the previous step
    self.signIn.scopes = @[ kGTLAuthScopePlusLogin ];  // "https://www.googleapis.com/auth/plus.login" scope
    //self.signIn.scopes = @[ @"profile" ];            // "profile" scope
    
    // Optional: declare self.signIn.actions, see "app activities"
    self.signIn.delegate = self;
    
    
    if(![self.signIn trySilentAuthentication]){
        UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        WRLoginViewController *myView = [story instantiateViewControllerWithIdentifier:@"loginStory"];
        myView.appDelegate=self;
        self.window.rootViewController = myView;
        
    }
    
//    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//    UIViewController *myView = [story instantiateViewControllerWithIdentifier:@"loginStory"];
//    self.window.rootViewController = myView;
    
}

- (void) entermainpage{
    if (self.signIn.userEmail && [WRRealmUsers objectsWhere:@"email=%@",self.signIn.userEmail].count!=0) {
        WRRealmUsers* users=[[WRRealmUsers alloc] init];
        RLMRealm *realm=[RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        users.email=self.signIn.userEmail;
        users.idToken=self.signIn.idToken;
        [realm addObject:users];
        [realm commitWriteTransaction];
    }
    
    WRFiveViewManager *wrFiveViewManager = [WRFiveViewManager sharedInstance];
    [wrFiveViewManager setBgColor:[UIColor pomegranateColor]];
    IIViewDeckController *deckViewController = [wrFiveViewManager getDeckController];
    self.window.rootViewController = deckViewController;
    
}


- (void)surfboard:(SRFSurfboardViewController *)surfboard didShowPanelAtIndex:(NSInteger)index
{
    //    NSLog(@"Index: %i", index);
}

- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth
                   error: (NSError *) error {
    if (error) {
        // Do some error handling here.
        NSLog(@"Error");
        [self.signIn authenticate];
    } else {
        NSLog(@"Successful Login");
        
        WRFiveViewManager *wrFiveViewManager = [WRFiveViewManager sharedInstance];
        [wrFiveViewManager setBgColor:[UIColor pomegranateColor]];
        IIViewDeckController *deckViewController = [wrFiveViewManager getDeckController];
        
        
        //store user_info
        if (self.signIn.userEmail&&[WRRealmUsers objectsWhere:@"email=%@",self.signIn.userEmail].count!=0) {
            WRRealmUsers* users=[[WRRealmUsers alloc] init];
            RLMRealm *realm=[RLMRealm defaultRealm];
            [realm beginWriteTransaction];
            users.email=self.signIn.userEmail;
            users.idToken=self.signIn.idToken;
            [realm addObject:users];
            [realm commitWriteTransaction];
        }
        
        
        
        
        self.window.rootViewController = deckViewController;
    }
}


@end
