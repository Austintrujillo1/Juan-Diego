//
//  AppDelegate.m
//  Juan Diego
//
//  Created by Austin Trujillo on 25 6 13.
//  Copyright (c) 2013 ATD. All rights reserved.
//
// No Comment


#import <Parse/Parse.h>
#import "AppDelegate.h"
#import "PowerschoolViewController.h"


@implementation AppDelegate


    //      ************************************
    //      * Application Did Finish Launching *
    //      ************************************


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
    #warning Change Parse Keys Before Submitting to Apple
    
    [Parse setApplicationId:@"s4YjmRLx7vaeKzRPHkrHyeFXetUvZig4kBRkbMZ9"
                  clientKey:@"4mQciMfQDW44aYYsGytkmIC1e32VtMF1JDytv3PC"];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];

    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|
     UIRemoteNotificationTypeAlert|
     UIRemoteNotificationTypeSound];
    
    return YES;
    
}


    //      *********************
    //      * Register For Push *
    //      *********************


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken {
    
    [PFPush storeDeviceToken:newDeviceToken];
    [PFPush subscribeToChannelInBackground:@"" target:self selector:@selector(subscribeFinished:error:)];

}


    //      *************************
    //      * Register Device Token *
    //      *************************



- (void)subscribeFinished:(NSNumber *)result error:(NSError *)error {
    
    if ([result boolValue]) {
        NSLog(@"Parse successfully subscribed to push notifications on the broadcast channel.");
    }
    
    else {
        NSLog(@"Parse failed to subscribe to push notifications on the broadcast channel.");
    }
}


    //      *************************
    //      * Clear Badge Upon Open *
    //      *************************


-(void)applicationWillEnterForeground:(UIApplication *)application {
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
}


- (void) applicationDidBecomeActive:(UIApplication *)application{
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
}

-(void)applicationDidFinishLaunching:(UIApplication *)application {
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
}
@end