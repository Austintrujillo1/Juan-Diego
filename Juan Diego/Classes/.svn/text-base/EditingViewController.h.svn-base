//
//  EditingViewController.h
//  GoogleCalendar
//
//  Created by Dan Bourque on 4/28/09.
//  Copyright Dan Bourque 2009. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "GDataCalendar.h"
#import "RootViewController.h"

@interface EditingViewController : UIViewController <UITextFieldDelegate>{
  RootViewController *rootViewController;
  GDataEntryCalendarEvent *editingEvent;
  GDataEntryCalendar *editingCalendar;
  IBOutlet UITextField *what;
  IBOutlet UIDatePicker *when;
  IBOutlet UITextField *where;
  UIView *headerView;
}

@property (nonatomic, retain) RootViewController *rootViewController;
@property (nonatomic, retain) GDataEntryCalendarEvent *editingEvent;
@property (nonatomic, retain) GDataEntryCalendar *editingCalendar;

@end