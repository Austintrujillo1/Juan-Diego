//
//  EditingViewController.m
//  GoogleCalendar
//
//  Created by Dan Bourque on 4/28/09.
//  Copyright Dan Bourque 2009. All rights reserved.
//
#import "EditingViewController.h"
#import "RootViewController.h"

@implementation EditingViewController

@synthesize rootViewController, editingEvent, editingCalendar;

- (void)viewWillAppear:(BOOL)animated{
  self.title = [[editingCalendar title] stringValue];
  // If the editing item is nil, that indicates a new item should be created
  if( !editingEvent ){
    what.text = @"";
    where.text = @"";
    when.date = [NSDate dateWithTimeIntervalSinceNow:60*30];  // Defaults to 30 minutes from now...
  }else{
    NSLog( @"Modifying item: %@", editingEvent );
    
    GDataWhen *eventWhen = [[editingEvent objectsForExtensionClass:[GDataWhen class]] objectAtIndex:0];
    what.text = [[editingEvent title] stringValue];
    where.text = [[[editingEvent locations] objectAtIndex:0] stringValue];
    when.date = [[eventWhen startTime] date];
  }
}

- (void)viewDidLoad{
 	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
  // use an empty view to position the cells in the vertical center of
  // the portion of the view not covered by the keyboard
  headerView = [[[UIView alloc] initWithFrame:CGRectMake( 0, 0, 5, 100 )] autorelease];
  
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem  alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                         target:self
                                                                                         action:@selector( cancel )];
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem  alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                          target:self
                                                                                          action:@selector( save )];
  
  what.clearButtonMode = UITextFieldViewModeWhileEditing;
	what.delegate = self;
  where.clearButtonMode = UITextFieldViewModeWhileEditing;
	where.delegate = self;  
}

// This class was declared as the 'what' and 'where' fields' delegate, so this method is
// called when the 'done' key is pressed.  We dismiss the keyboard, but don't return from the screen.
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	[textField resignFirstResponder];
	return NO;
}

- (IBAction)cancel{
  [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)save{
  GDataDateTime *time = [GDataDateTime dateTimeWithDate:when.date timeZone:when.timeZone];

  if( !editingEvent ){  // If an editingItem wasn't provided, then we're creating a new entry.
    GDataEntryCalendarEvent *newEntry = [GDataEntryCalendarEvent calendarEvent];
    [newEntry setTitleWithString:what.text];
    [newEntry addLocation:[GDataWhere whereWithString:where.text]];
    [newEntry addTime:[GDataWhen whenWithStartTime:time endTime:time]];
    [rootViewController insertCalendarEvent:newEntry toCalendar:editingCalendar];
  }else{
    [editingEvent setTitleWithString:what.text];
    [editingEvent setLocations:[NSArray arrayWithObject:[GDataWhere whereWithString:where.text]]];
    // I haven't figured this out yet, but calling setTimes throws an exception, since the editingEvent is *not* an instance of
    // GDataEntryCalendarEvent, but of GDataEntryCalendar.  I suspect it's a bug in Google's client libs, but I'm not certain.
    // These entries came from the fetching of each calendar's alternateLinks, which *should* have returned GDataEntryCalendarEvent objects,
    // according to Google's documentation and samples.
//    [editingEvent setTimes:[NSArray arrayWithObject:[GDataWhen whenWithStartTime:time endTime:time]]];
    [rootViewController updateCalendarEvent:editingEvent];
  }

  [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc{
  [rootViewController release];
  [editingEvent release];
  [editingCalendar release];
  [what release];
  [when release];
  [where release];
  [headerView release];
  [super dealloc];
}

@end