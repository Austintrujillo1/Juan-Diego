//
//  RootViewController.m
//  GoogleCalendar
//
//  Created by Dan Bourque on 4/26/09.
//  Copyright Dan Bourque 2009. All rights reserved.
//

#import "RootViewController.h"
#import "AppDelegate.h"
#import "DetailCell.h"
#import "EditingViewController.h"

@implementation RootViewController

@synthesize googleCalendarService;

- (id)initWithCoder:(NSCoder *)aCoder{
  if( self=[super initWithCoder:aCoder] ){
    googleCalendarService = [[GDataServiceGoogleCalendar alloc] init];
    [googleCalendarService setUserAgent:@"DanBourque-GTUGDemo-1.0"];
    // We'll follow the links ourselves, so that we can show progress to our users between each batch.
    [googleCalendarService setServiceShouldFollowNextLinks:NO];
    data = [[NSMutableArray alloc] init];
  }
  return self;
}

- (void)viewDidLoad{
  [super viewDidLoad];	
  self.navigationItem.rightBarButtonItem = self.editButtonItem;
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem  alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                         target:self
                                                                                         action:@selector( refresh )];
  // At this point, the application delegate will have loaded the app's preferences, so set the service's credentials.
  AppDelegate *appDelegate = [AppDelegate appDelegate];
  [googleCalendarService setUserCredentialsWithUsername:appDelegate.username
                                               password:appDelegate.password];  
  [self refresh];   // Start the fetch process.
}

- (void)viewWillAppear:(BOOL)animated{
  [self.tableView reloadData];
}

- (EditingViewController *)editingViewController{
  if( !editingViewController )  // Lazily Instantiate the editing view controller if necessary.
    editingViewController = [[EditingViewController alloc] initWithNibName:@"EditingView" bundle:nil];
  return editingViewController;
}

- (void)dealloc{
  [navigationBar release];
  [data release];
  [editingViewController release];
  [super dealloc];
}

#pragma mark Utility methods for searching index paths.

- (NSDictionary *)dictionaryForIndexPath:(NSIndexPath *)indexPath{
  if( indexPath.section<[data count] )
    return [data objectAtIndex:indexPath.section];
  return nil;
}

- (NSMutableArray *)eventsForIndexPath:(NSIndexPath *)indexPath{
  NSDictionary *dictionary = [self dictionaryForIndexPath:indexPath];
  if( dictionary )
    return [dictionary valueForKey:KEY_EVENTS];
  return nil;
}

- (GDataEntryCalendarEvent *)eventForIndexPath:(NSIndexPath *)indexPath{
  NSMutableArray *events = [self eventsForIndexPath:indexPath];
  if( events && indexPath.row<[events count] )
    return [events objectAtIndex:indexPath.row];
  return nil;
}

#pragma mark Google Data APIs

- (void)refresh{
  // Note: The next call returns a ticket, that could be used to cancel the current request if the user chose to abort early.
  // However since I didn't expose such a capability to the user, I don't even assign it to a variable.
  [data removeAllObjects];

  [googleCalendarService fetchCalendarFeedForUsername:[AppDelegate appDelegate].username
                                             delegate:self
                                    didFinishSelector:@selector( calendarsTicket:finishedWithFeed:error: )];
}

- (void)handleError:(NSError *)error{
  NSString *title, *msg;
  if( [error code]==kGDataBadAuthentication ){
    title = @"Authentication Failed";
    msg = @"Invalid username/password\n\nPlease go to the iPhone's settings to change your Google account credentials.";
  }else{
    // some other error authenticating or retrieving the GData object or a 304 status
    // indicating the data has not been modified since it was previously fetched
    title = @"Unknown Error";
    msg = [error localizedDescription];
  }

  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                  message:msg
                                                 delegate:nil
                                        cancelButtonTitle:@"Ok"
                                        otherButtonTitles:nil];
  [alert show];
  [alert release];
}

- (void)calendarsTicket:(GDataServiceTicket *)ticket finishedWithFeed:(GDataFeedCalendar *)feed error:(NSError *)error{
  if( !error ){
    int count = [[feed entries] count];
    for( int i=0; i<count; i++ ){
      GDataEntryCalendar *calendar = [[feed entries] objectAtIndex:i];

      // Create a dictionary containing the calendar and the ticket to fetch its events.
      NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
      [data addObject:dictionary];

      [dictionary setObject:calendar forKey:KEY_CALENDAR];
      [dictionary setObject:[[NSMutableArray alloc] init] forKey:KEY_EVENTS];

      if( [calendar ACLLink] )  // We can determine whether the calendar is under user's control by the existence of its edit link.
        [dictionary setObject:KEY_EDITABLE forKey:KEY_EDITABLE];

      NSURL *feedURL = [[calendar alternateLink] URL];
      if( feedURL ){
        GDataQueryCalendar* query = [GDataQueryCalendar calendarQueryWithFeedURL:feedURL];

        // Currently, the app just shows calendar entries from 15 days ago to 31 days from now.
        // Ideally, we would instead use similar controls found in Google Calendar web interface, or even iCal's UI.
        NSDate *minDate = [NSDate date];  // From right now...
        NSDate *maxDate = [NSDate dateWithTimeIntervalSinceNow:60*60*24*90];  // ...to 90 days from now.

        [query setMinimumStartTime:[GDataDateTime dateTimeWithDate:minDate timeZone:[NSTimeZone systemTimeZone]]];
        [query setMaximumStartTime:[GDataDateTime dateTimeWithDate:maxDate timeZone:[NSTimeZone systemTimeZone]]];
        [query setOrderBy:@"starttime"];  // http://code.google.com/apis/calendar/docs/2.0/reference.html#Parameters
        [query setIsAscendingOrder:YES];
        [query setShouldExpandRecurrentEvents:YES];

        GDataServiceTicket *ticket = [googleCalendarService fetchFeedWithQuery:query
                                                                      delegate:self
                                                             didFinishSelector:@selector( eventsTicket:finishedWithEntries:error: )];
        // I add the service ticket to the dictionary to make it easy to find which calendar each reply belongs to.
        [dictionary setObject:ticket forKey:KEY_TICKET];
      }
    }
  }else
    [self handleError:error];

  [self.tableView reloadData];
}

- (void)eventsTicket:(GDataServiceTicket *)ticket finishedWithEntries:(GDataFeedCalendarEvent *)feed error:(NSError *)error{
  if( !error ){
    NSMutableDictionary *dictionary;
    for( int section=0; section<[data count]; section++ ){
      NSMutableDictionary *nextDictionary = [data objectAtIndex:section];
      GDataServiceTicket *nextTicket = [nextDictionary objectForKey:KEY_TICKET];
      if( nextTicket==ticket ){		// We've found the calendar these events are meant for...
        dictionary = nextDictionary;
        break;
      }
    }

    if( !dictionary )
      return;		// This should never happen.  It means we couldn't find the ticket it relates to.

    int count = [[feed entries] count];

    NSMutableArray *events = [dictionary objectForKey:KEY_EVENTS];
    for( int i=0; i<count; i++ )
      [events addObject:[[feed entries] objectAtIndex:i]];

    [self.tableView reloadData];

    NSURL *nextURL = [[feed nextLink] URL];
    if( nextURL ){    // There are more events in the calendar...  Fetch again.
      GDataServiceTicket *newTicket = [googleCalendarService fetchFeedWithURL:nextURL
                                                                     delegate:self
                                                            didFinishSelector:@selector( eventsTicket:finishedWithEntries:error: )];   // Right back here...
      // Update the ticket in the dictionary for the next batch.
      [dictionary setObject:newTicket forKey:KEY_TICKET];
    }
  }else
    [self handleError:error];
}

- (void)deleteCalendarEvent:(GDataEntryCalendarEvent *)event{
  [googleCalendarService deleteEntry:event
                            delegate:self
                   didFinishSelector:nil];
}

- (void)insertCalendarEvent:(GDataEntryCalendarEvent *)event toCalendar:(GDataEntryCalendar *)calendar{
  [googleCalendarService fetchEntryByInsertingEntry:event
                                         forFeedURL:[[calendar alternateLink] URL]
                                           delegate:self
                                  didFinishSelector:@selector( insertTicket:finishedWithEntry:error: )];
}

- (void)insertTicket:(GDataServiceTicket *)ticket finishedWithEntry:(GDataEntryCalendarEvent *)entry error:(NSError *)error{
  if( !error )
    [self refresh];
  else
    [self handleError:error];
}

- (void)updateCalendarEvent:(GDataEntryCalendarEvent *)event{
  [googleCalendarService fetchEntryByUpdatingEntry:event
                                       forEntryURL:[[event editLink] URL]
                                          delegate:self
                                 didFinishSelector:nil];
}

#pragma mark Table Content and Appearance

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  return MAX( [data count], 1 );
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
  if( section<[data count] ){
    NSMutableDictionary *dictionary = [data objectAtIndex:section];
    GDataEntryCalendar *calendar = [dictionary objectForKey:KEY_CALENDAR];
    NSMutableArray *events = [dictionary objectForKey:KEY_EVENTS];
    int count = [events count];
    return [NSString stringWithFormat:@"%@ (%i)", [[calendar title] stringValue], count];
  }
  return @"Please wait...";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  if( section>=[data count] )
    return 0;
  
  NSMutableDictionary *dictionary = [data objectAtIndex:section];
  NSMutableArray *events = [dictionary objectForKey:KEY_EVENTS];
  int count = [events count];
  
  // If we're in editing mode, we add a placeholder row for creating new items.
  // However, only add it to the calendars that allow editing.  Not all do.
  if( self.editing && [dictionary objectForKey:KEY_EDITABLE] )	
    count++;
  
  return count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  static NSString *CellIdentifier = @"DetailCell";
  DetailCell *cell = (DetailCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if( !cell ){
    cell = [[[DetailCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    cell.accessoryType = UITableViewCellAccessoryNone;
  }
  
  cell.date.text = cell.time.text = cell.name.text = cell.addr.text = @"";
  NSArray *events = [self eventsForIndexPath:indexPath];
  
  // The DetailCell has two modes of display - either the typical record or a prompt for creating a new item
  if( indexPath.row<[events count] ){
    GDataEntryCalendarEvent *event = [events objectAtIndex:indexPath.row];
    GDataWhen *when = [[event objectsForExtensionClass:[GDataWhen class]] objectAtIndex:0];
    if( when ){
      NSDate *date = [[when startTime] date];
      NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

      [dateFormatter setDateFormat:@"yy-MM-dd"];
      cell.date.text = [dateFormatter stringFromDate:date];
      [dateFormatter setDateFormat:@"HH:mm"];
      cell.time.text = [dateFormatter stringFromDate:date];

      [dateFormatter release];
    }
    cell.name.text = [[event title] stringValue];
    // Note: An event might have multiple locations.  We're only displaying the first one.
    GDataWhere *addr = [[event locations] objectAtIndex:0];
    if( addr )
      cell.addr.text = [addr stringValue];

    cell.promptMode = NO;
  }else{
    cell.prompt.text = @"Create new event";
    cell.promptMode = YES;
  }
  
  return cell;
}

// The accessory view is on the right side of each cell. We'll use a "disclosure" indicator in editing mode,
// to indicate to the user that selecting the row will navigate to a new view where details can be edited.
- (UITableViewCellAccessoryType)tableView:(UITableView *)aTableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath{
  if( self.editing && [[self dictionaryForIndexPath:indexPath] objectForKey:KEY_EDITABLE] )
    return UITableViewCellAccessoryDisclosureIndicator;
  return UITableViewCellAccessoryNone;
}

// Prevent editing of calendar events that aren't editable at the Google cloud.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
  GDataEntryCalendarEvent *event = [self eventForIndexPath:indexPath];
  if( event )
    return [event canEdit];
  return YES;   // However, the "add new item" entry is "editable".
}

// The editing style for a row is the kind of button displayed to the left of the cell when in editing mode.
- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
  if( !self.editing || !indexPath )
    return UITableViewCellEditingStyleNone; // No editing style if not editing or the index path is nil.
  
  // Determine the editing style based on whether the cell is a placeholder for
  // adding content or already existing content. Existing content can be deleted.
  
  NSArray *events = [self eventsForIndexPath:indexPath];
  if( events )
    return indexPath.row>=[events count]?UITableViewCellEditingStyleInsert:UITableViewCellEditingStyleDelete;
  return UITableViewCellEditingStyleNone;
}

#pragma mark Editing

- (void)editEntryAtIndexPath:(NSIndexPath *)indexPath{
  // Go to edit view
  NSDictionary *dictionary = [self dictionaryForIndexPath:indexPath];
  if( dictionary ){
    GDataEntryCalendar *calendar = [dictionary objectForKey:KEY_CALENDAR];
    // Make a local reference to the editing view controller.
    EditingViewController *controller = self.editingViewController;
    // Pass the item being edited to the editing controller.
    // If the user clicked on the "add new entry" record, this will be nil, and the controller will create a new one.
    controller.editingEvent = [self eventForIndexPath:indexPath];
    // Also pass the containing calendar, so that it may add new entries to it.
    controller.editingCalendar = calendar;
    controller.rootViewController = self;
    [self.navigationController pushViewController:controller animated:YES];
  }
}

// Called after selection. In editing mode, this will navigate to a new view controller.
- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  if( !self.editing || ![[self dictionaryForIndexPath:indexPath] objectForKey:KEY_EDITABLE] ){ // This will give the user visual feedback that the cell was selected but fade out to indicate that no action is taken.
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    return;
  }
  
  // Don't maintain the selection. We will navigate to a new view so there's no reason to keep the selection here.
  [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
  [self editEntryAtIndexPath:indexPath];
}

// Set the editing state of the view controller. We pass this down to the table view and also modify the content
// of the table to insert a placeholder row for adding content when in editing mode.
- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
  [super setEditing:editing animated:animated];
  // Calculate the index paths for all of the placeholder rows based on the number of items in each section.
  NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
  for( int section=0; section<[data count]; section++ ){
    NSMutableDictionary *dictionary = [data objectAtIndex:section];
    if( [dictionary objectForKey:KEY_EDITABLE] ){
      NSArray *events = [dictionary objectForKey:KEY_EVENTS];
      [indexPaths addObject:[NSIndexPath indexPathForRow:[events count] inSection:section]];
    }
  }
  
  [self.tableView beginUpdates];
  [self.tableView setEditing:editing animated:YES];
  if( editing )  // Show the placeholder rows
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
  else    // Hide the placeholder rows.
    [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
  [self.tableView endUpdates];
  [indexPaths release];
}

// Update the data model according to edit actions delete or insert.
- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
                                             forRowAtIndexPath:(NSIndexPath *)indexPath{
  switch( editingStyle ){
    case UITableViewCellEditingStyleDelete:{
      NSMutableArray *events = [self eventsForIndexPath:indexPath];
      if( events && indexPath.row<[events count] ){
        GDataEntryCalendarEvent *event = [events objectAtIndex:indexPath.row];
        if( event ){
          [self deleteCalendarEvent:event];
          [events removeObject:event];
          // We can animate the deletion, optimistic that it will be deleted at the cloud.  If it fails, it will simply reappear.
          [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];      
        }
      }
    }break;
    case UITableViewCellEditingStyleInsert:
      [self editEntryAtIndexPath:indexPath];
    break;
  }
}

@end