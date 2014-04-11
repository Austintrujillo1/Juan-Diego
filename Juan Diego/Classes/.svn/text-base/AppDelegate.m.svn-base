//
//  AppDelegate.m
//  GoogleCalendar
//
//  Created by Dan Bourque on 4/26/09.
//  Copyright Dan Bourque 2009. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window, navigationController, username, password;

- (void)applicationDidFinishLaunching:(UIApplication *)application{
  [self loadSettings];

  [window addSubview:navigationController.view];  // Add the navigation controller's view to the window.
  [window makeKeyAndVisible];  // Show window
}

- (void)applicationWillTerminate:(UIApplication *)application{
  [self storeSettings];
}

+ (AppDelegate *)appDelegate{		// Static accessor
  return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)dealloc{
  [navigationController release];
  [window release];
  [username release];
  [password release];
  [super dealloc];
}

#pragma mark -
#pragma mark Settings accessors

- (void)loadSettings{
  CFPreferencesAppSynchronize( kCFPreferencesCurrentApplication );

  username = (NSString*)CFPreferencesCopyAppValue( PREF_USERNAME, kCFPreferencesCurrentApplication );
  if( !username )
    username = @"username@gmail.com";
  if( ![username rangeOfString:@"@"].length )		// If the domain isn't specified, then default to gmail.com.  It may be a different domain, however.
    username = [username stringByAppendingString:@"@gmail.com"];

  password = (NSString*)CFPreferencesCopyAppValue( PREF_PASSWORD, kCFPreferencesCurrentApplication );
  if( !password )
    password = @"password";
}

- (void)storeSettings{
  CFPreferencesSetAppValue( PREF_USERNAME, username, kCFPreferencesCurrentApplication );
  CFPreferencesSetAppValue( PREF_PASSWORD, password, kCFPreferencesCurrentApplication );
  CFPreferencesAppSynchronize( kCFPreferencesCurrentApplication );
}

@end