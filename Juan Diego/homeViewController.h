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

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1

#define kGoogleCalendarURL [NSURL URLWithString:  @"http://www.google.com/calendar/feeds/skaggscatholiccenter.org_thk1g5avnsmmje4of881iqeelo%40group.calendar.google.com/public/full?alt=json&orderby=starttime&max-results=15&singleevents=true&sortorder=ascending&futureevents=true"]

@interface HomeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *tableView;
    
    NSMutableArray *_EventArray;
    
    NSInteger selectedRow;
}


@property (nonatomic, strong) IBOutlet UILabel *dayLabel;
@property (nonatomic, strong) IBOutlet UILabel *infinativeLabel;
@property (nonatomic, strong) IBOutlet UILabel *todayLabel;

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *EventArray;
@property (nonatomic, assign) NSInteger selectedRow;


-(void)LoadCalendarData;


@end
