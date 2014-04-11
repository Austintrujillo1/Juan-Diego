//
//  HomeViewController.h
//  Juan Diego
//
//  Created by Austin Trujillo on 8/4/13.
//  Copyright (c) 2013 ATD. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Foundation/NSJSONSerialization.h>
#import "GoogCal.h"
#import "Day.h"

//Define Event Calendar URL
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1
#define kGoogleCalendarURL [NSURL URLWithString:  @"http://www.google.com/calendar/feeds/skaggscatholiccenter.org_thk1g5avnsmmje4of881iqeelo%40group.calendar.google.com/public/full?alt=json&orderby=starttime&max-results=15&singleevents=true&sortorder=ascending&futureevents=true"]

@class Reachability;

@interface HomeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
        
    Reachability *internetReach;
    
    UITableView *tableView;
    NSMutableArray *_EventArray;
    NSMutableArray *_LunchArray;
    NSInteger selectedRow;
    
}

@property (nonatomic, strong) IBOutlet UILabel *lunchLabel;
@property (nonatomic, strong) IBOutlet UILabel *dayLabel;
@property (nonatomic, strong) IBOutlet UILabel *lunchday;
@property (nonatomic, strong) IBOutlet UILabel *infinativeLabel;
@property (nonatomic, strong) IBOutlet UILabel *todayLabel;
@property (nonatomic, strong) IBOutlet UIImageView *logoImage;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityView;
@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic, retain) NSMutableArray *EventArray;
@property (nonatomic, assign) NSInteger selectedRow;
@property (nonatomic, strong) NSMutableDictionary *dayDict;

-(void)LoadCalendarData;

@end
