//
//  AppDelegate.h
//  Juan Diego
//
//  Created by Austin Trujillo on 25 6 13.
//  Copyright (c) 2013 ATD. All rights reserved.
//
//  MajorT0m


#import <UIKit/UIKit.h>
#import "Day.h"

@class Reachability;
@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    
    Reachability *internetReach;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) Day *callDayClass;

@end