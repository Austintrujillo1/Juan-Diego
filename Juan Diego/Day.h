//
//  Day.h
//  Juan Diego
//
//  Created by Austin Trujillo on 10/17/13.
//  Copyright (c) 2013 ATD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/NSJSONSerialization.h>
#import "GoogCal.h"

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1

#define ADayCalendar [NSURL URLWithString:  @"http://www.google.com/calendar/feeds/skaggscatholiccenter.org_7hn7ok46eclmnlcd6e6k4mk018%40group.calendar.google.com/public/full?alt=json&orderby=starttime&max-results=1&singleevents=true&sortorder=ascending&futureevents=true"]


#define BDayCalendar [NSURL URLWithString:  @"http://www.google.com/calendar/feeds/skaggscatholiccenter.org_hdgui4ouk2mi7ascocqi183ufk%40group.calendar.google.com/public/full?alt=json&orderby=starttime&max-results=1&singleevents=true&sortorder=ascending&futureevents=true"]

#define CDayCalendar [NSURL URLWithString:  @"http://www.google.com/calendar/feeds/skaggscatholiccenter.org_qin92ij3b1n29bgr6tjvm25ie0%40group.calendar.google.com/public/full?alt=json&orderby=starttime&max-results=1&singleevents=true&sortorder=ascending&futureevents=true"]

#define DDayCalendar [NSURL URLWithString:  @"http://www.google.com/calendar/feeds/skaggscatholiccenter.org_n8l67l2qi5dktjha2cfqnjduik%40group.calendar.google.com/public/full?alt=json&orderby=starttime&max-results=1&singleevents=true&sortorder=ascending&futureevents=true"]

@interface Day : UIViewController

@property (nonatomic, retain) NSMutableArray *aDayArray;
@property (nonatomic, retain) NSMutableArray *bDayArray;
@property (nonatomic, retain) NSMutableArray *cDayArray;
@property (nonatomic, retain) NSMutableArray *dDayArray;

@property (nonatomic, strong) NSDictionary *ADateDict;
@property (nonatomic, strong) NSDictionary *BDateDict;
@property (nonatomic, strong) NSDictionary *CDateDict;
@property (nonatomic, strong) NSDictionary *DDateDict;

@property (nonatomic, strong) IBOutlet UILabel *dayLabel;

@property (nonatomic, strong) NSString *todayString;


@end
