//
//  AppDelegate.m
//  Juan Diego
//
//  Created by Austin Trujillo on 25 6 13.
//  Copyright (c) 2013 ATD. All rights reserved.
//

    // No Comment

#import "AppDelegate.h"
#import <Parse/Parse.h>

@implementation AppDelegate


    //      **********************************
    //      * Application Will Resign Active *
    //      **********************************


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}


    //      ************************************
    //      * Application Did Enter Background *
    //      ************************************


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


    //      *************************************
    //      * Application Will Enter Foreground *
    //      *************************************


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


    //      *********************************
    //      * Application Did Become Active *
    //      *********************************


- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [Parse setApplicationId:@"BAIjvNdRhkUPB88Ajg47Ppy8bV0hj0HQ3zgML2Ex"
                  clientKey:@"ggF0i6emg3PLr0wZP8uqB0YVQRX15vg8FlCUplFz"];
    
    [application registerForRemoteNotificationTypes:
     UIRemoteNotificationTypeBadge |
     UIRemoteNotificationTypeAlert |
     UIRemoteNotificationTypeSound];
    
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    if (currentInstallation.badge != 0) {
        currentInstallation.badge = 0;
        [currentInstallation saveEventually];
    }
    
    /*
    
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        if (!error) {
    
            PFObject *locationClass = [PFObject objectWithClassName:@"Location"];
            
            NSString *deviceName = [[UIDevice currentDevice] name]; // e.g. "iPod touch"
            
            [locationClass setObject:geoPoint forKey:@"Location"];
            [locationClass setObject:deviceName forKey:@"DeviceName"];
            [locationClass save];
        }
    }];
     
     */
    
    
}


    //      *************************
    //      * Register Device Token *
    //      *************************


- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken {
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:newDeviceToken];
    
    [PFPush subscribeToChannelInBackground:@""];
    [currentInstallation saveInBackground];
}


    //      ***************
    //      * Handle Push *
    //      ***************


- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {

    [PFPush handlePush:userInfo];
}


    //      ******************************
    //      * Application Will Terminate *
    //      ******************************


- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end