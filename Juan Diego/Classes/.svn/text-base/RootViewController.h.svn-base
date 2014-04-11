//
//  RootViewController.h
//  GoogleCalendar
//
//  Created by Dan Bourque on 4/26/09.
//  Copyright Dan Bourque 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDataCalendar.h"

// These keys are used to lookup elements in our dictionaries.
#define KEY_CALENDAR @"calendar"
#define KEY_EVENTS @"events"
#define KEY_TICKET @"ticket"
#define KEY_EDITABLE @"editable"

// Forward declaration of the editing view controller's class for the compiler.
@class EditingViewController;

@interface RootViewController : UITableViewController{
  UINavigationBar* navigationBar;
  NSMutableArray *data;
  GDataServiceGoogleCalendar *googleCalendarService;
  EditingViewController *editingViewController;
}

// We declare accessor for the googleCalendarService because we need to access it from the EditingViewController class.
@property (nonatomic, retain) GDataServiceGoogleCalendar *googleCalendarService;

- (void)refresh;
- (void)insertCalendarEvent:(GDataEntryCalendarEvent *)event toCalendar:(GDataEntryCalendar *)calendar;
- (void)updateCalendarEvent:(GDataEntryCalendarEvent *)event;

@end