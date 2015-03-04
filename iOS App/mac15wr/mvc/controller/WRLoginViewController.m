//
//  WRLoginViewController.m
//  mac15wr
//
//  Created by Alex on 2/14/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import "WRLoginViewController.h"

#import <GoogleOpenSource/GoogleOpenSource.h>
#import <GooglePlus/GooglePlus.h>
#import "ViewController.h"
#import "WRFiveViewManager.h"

@implementation WRLoginViewController



// Please use the client ID created for you by Google.
static NSString * const kClientID =
@"505486916113-8mdlode4utlqdoq7vr83l0ric7g5h6r9.apps.googleusercontent.com";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //ui settting
    //background
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_trajons.jpg"]];
    
    
    //google login
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

    
    [self.signIn trySilentAuthentication];
}



#pragma test to hid g+ self.signIn button
-(void)refreshInterfaceBasedOnsignIn {
    if ([[GPPSignIn sharedInstance] authentication]) {
        // The user is signed in.
        self.signInButton.hidden = YES;
        // Perform other actions here, such as showing a sign-out button
    } else {
        self.signInButton.hidden = NO;
        // Perform other actions here
    }
}

- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth
                   error: (NSError *) error {
    if (error) {
        // Do some error handling here.
    } else {
        [self.appDelegate entermainpage];
        
        
    }
}

//- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    if ([[segue identifier] isEqualToString:@"login"]) {
//        UINavigationController *nav = [segue destinationViewController];
//        ViewController* userViewController = (ViewController *) nav.topViewController;
//        userViewController.email = self.signIn.userEmail;
//    }
//}



@end
