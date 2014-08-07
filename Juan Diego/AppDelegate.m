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
#import "Day.h"
#import "PowerschoolViewController.h"
#import "Reachability.h"

@implementation AppDelegate

- (NSString *) dataFilePath {       //Get "Today.plist" Filepath
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentDirectory = [path objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"Today.plist"];
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {      //Did Finish Launching With Options
    
    //Set Plist Elements to ""
    NSMutableDictionary *plistToWrite = [NSMutableDictionary dictionary];
    
    [plistToWrite setObject:@"" forKey:@"Lunch"];
    [plistToWrite setObject:@"" forKey:@"Today"];
    [plistToWrite setObject:@"" forKey:@"Date"];
    [plistToWrite writeToFile:[self dataFilePath] atomically:YES];
    
    //Set Parse IDs
    [Parse setApplicationId:@"BAIjvNdRhkUPB88Ajg47Ppy8bV0hj0HQ3zgML2Ex"
                  clientKey:@"ggF0i6emg3PLr0wZP8uqB0YVQRX15vg8FlCUplFz"];
    
    //Register For Push
    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|
     UIRemoteNotificationTypeAlert|
     UIRemoteNotificationTypeSound];
    
    
    return YES;
    
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken {        //Did Register For Remote Notifications
    [PFPush storeDeviceToken:newDeviceToken];
    [PFPush subscribeToChannelInBackground:@"" target:self selector:@selector(subscribeFinished:error:)];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {        //Did Fail To Register For Remote Notifications
    if (error.code == 3010) {
        NSLog(@"Push notifications are not supported in the iOS Simulator.");
    } else {
        // show some alert or otherwise handle the failure to register.
        NSLog(@"application:didFailToRegisterForRemoteNotificationsWithError: %@", error);
	}
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {        //Did Recieve Remote Notification
    
    if (application.applicationState == UIApplicationStateInactive) {
        [PFAnalytics trackAppOpenedWithRemoteNotificationPayload:userInfo];
    }
}

- (void)subscribeFinished:(NSNumber *)result error:(NSError *)error {        //Parse Subscription Finished
    if ([result boolValue]) {
        NSLog(@"Juan Diego successfully subscribed to push notifications on the broadcast channel.");
    } else {
        NSLog(@"Juan Diego failed to subscribe to push notifications on the broadcast channel.");
    }
}


-(void)applicationWillEnterForeground:(UIApplication *)application {        //Clear Badge
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
}


- (void) applicationDidBecomeActive:(UIApplication *)application{        //Clear Badge
    
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
}

-(void)applicationDidFinishLaunching:(UIApplication *)application {        //Clear Badge
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
}
@end