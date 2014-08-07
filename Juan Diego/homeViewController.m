//
//  HomeViewController.m
//  Juan Diego
//
//  Created by Austin Trujillo on 8/4/13.
//  Copyright (c) 2013 ATD. All rights reserved.
//

#import "HomeViewController.h"
#import "ISO8601DateFormatter.h"
#import <Parse/Parse.h>
#import <MapKit/MapKit.h>
#import "Day.h"
#import "Reachability.h"

@interface HomeViewController ()
@end


@implementation HomeViewController


@synthesize EventArray = _EventArray;
@synthesize tableView = _tableView;
@synthesize activityView = _activityView;
@synthesize selectedRow;
@synthesize lunchday = _lunchday;
@synthesize dayLabel = _dayLabel;
@synthesize infinativeLabel = _infinativeLabel;
@synthesize todayLabel = _todayLabel;
@synthesize lunchLabel = _lunchLabel;
@synthesize logoImage = _logoImage;
@synthesize dayDict;
@synthesize breakArray;
@synthesize boolString = _boolString;
@synthesize todaysDate = _todaysDate;
@synthesize summerLabel = _summerLabel;

    //      ********************
    //      * Status Bar Color *
    //      ********************


- (UIStatusBarStyle) preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
    
}


- (NSString *) dataFilePath {
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentDirectory = [path objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"Today.plist"];
}

    //      ******************
    //      * Refresh Button *
    //      ******************


- (IBAction)refreshButton:(id)sender {
    
    Day *getToday;
    getToday = [[Day alloc] init];
    
    //Refresh Items
    
    [self dayChecker];
    [self preferredStatusBarStyle];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self reloadTableview];
    [self startActivityIndicator:nil];
    [self checkBreaks];
    [getToday loadAllData];
    [self performSelector:@selector(stopActivityIndicator:) withObject:nil afterDelay: 0.9];
    
}


- (IBAction)startActivityIndicator:(id)sender{
    
    [_activityView startAnimating];     //Start Activity Indicator
    
}


- (IBAction)stopActivityIndicator:(id)sender{
    
    [_activityView stopAnimating];      //Stop Activity Indicator
}


-(void)viewWillAppear:(BOOL)animated {
    
    [self checkBreaks];
    
    internetReach = [Reachability reachabilityForInternetConnection];
    [internetReach startNotifier];
    
    NetworkStatus netStatus = [internetReach currentReachabilityStatus];
    
    switch (netStatus){
        case ReachableViaWWAN:{
            
            [_activityView startAnimating];
            
            [self reloadTableview];
            
            [self checkBreaks];
            
            [self performSelector:@selector(stopActivityIndicator:) withObject:nil afterDelay: 0.5];
            
            break;
        }
        case ReachableViaWiFi:{
            
            [_activityView startAnimating];
            
            [self reloadTableview];
            
            [self checkBreaks];
            
            [self performSelector:@selector(stopActivityIndicator:) withObject:nil afterDelay: 0.5];
            
            break;
        }
        case NotReachable:{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please connect to a WIFI network before starting. Functionality of this application will be limited." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            break;
        }
    }
    
}

- (void) checkBreaks {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Miscellaneous"];      //Create Query
    
    [query addDescendingOrder:@"createdAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error) {
            
            breakArray = objects;
            
            NSLog(@"BA: %@", breakArray);
            
            PFObject *breakResults = [breakArray objectAtIndex:0];
            
            _boolString = [breakResults objectForKey:@"BOOL"];
            
            [self checkPlist:nil];

            
        }
    }];
    

}


- (IBAction)checkPlist:(id)sender{
    
    Day *getToday;
    getToday = [[Day alloc] init];
    
    NSString *filePath = [self dataFilePath];
    
    dayDict = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];    //Declare Formatter
    [formatter setDateFormat:@"YYYY-MM-dd"];      //Format Date
    NSString *dateToday = [formatter stringFromDate:[NSDate date]];     //get the date today
    
    NSLog(@"BREAKMODE: %@", _boolString);
    
    NSLog(@"Dict: %@", dayDict);

    
    if ([_boolString isEqualToString:@"TRUE"]) {
        
        _summerLabel.hidden = TRUE;   //UNHide Logo
        
        _todaysDate = dateToday;
    }
    else if ([_boolString isEqualToString:@"FALSE"]){
        
        _summerLabel.hidden = FALSE;   //UNHide Logo
        
        _todaysDate = [dayDict objectForKey:@"Date"];
    }
    
    if ([_todaysDate isEqualToString:dateToday]) {
        
        NSLog(@"Its Today");
    
        _dayLabel.text = [dayDict objectForKey:@"Today"];
        
        [self dayChecker];
    }
    else{
        NSLog(@"Its not Today, its %@", dateToday);
        
        [getToday loadAllData];
        
        [self viewWillAppear:YES];
        
    }
    
}


- (void) reloadTableview {
    
    //Reload Table and Data
    
    [self LoadCalendarData];
    [_tableView reloadData];
    
}


- (void) dayChecker {
    
    _todayLabel.text = @"Day";

    if ([_dayLabel.text isEqualToString:@"A"]) {    //A Day
        _logoImage.hidden = TRUE;   //Hide Logo
        _infinativeLabel.text = @"Today is an"; //Infinative
        _lunchday.textColor = [UIColor lightGrayColor]; //Set Lunch Color
        _dayLabel.textColor = [UIColor colorWithRed:244.0/255.0 green:136.0/255.0 blue:190.0/255.0 alpha:1]; //Pink Color
        _infinativeLabel.textColor = [UIColor blackColor];  //Black Color
        _todayLabel.text = @"Day";
    }
        
    else if ([_dayLabel.text isEqualToString:@"B"]) {   //B Day
        _logoImage.hidden = TRUE;   //Hide Logo
        _infinativeLabel.text = @"Today is a";  //Infinative
        _lunchday.textColor = [UIColor lightGrayColor]; //Set Lunch Color
        _dayLabel.textColor = [UIColor colorWithRed:73.0/255.0 green:134.0/255.0 blue:231.0/255.0 alpha:1]; //Blue Color
        _infinativeLabel.textColor = [UIColor blackColor];  //Black Color
        _todayLabel.text = @"Day";
    }
        
    else if ([_dayLabel.text isEqualToString:@"C"]) {   //C Day
        _logoImage.hidden = TRUE;   //Hide Logo
        _infinativeLabel.text = @"Today is a";  //Infinative
        _lunchday.textColor = [UIColor lightGrayColor]; //Set Lunch Color
        _dayLabel.textColor = [UIColor colorWithRed:255.0/255.0 green:204.0/255.0 blue:0.0/255.0 alpha:1]; //Yellow Color
        _infinativeLabel.textColor = [UIColor blackColor];  //Clear Color
        _todayLabel.text = @"Day";
    }
        
    else if ([_dayLabel.text isEqualToString:@"D"]) {   //D Day
        _logoImage.hidden = TRUE;   //Hide Logo
        _lunchday.textColor = [UIColor lightGrayColor]; //Set Lunch Color
        _infinativeLabel.text = @"Today is a";  //Infinative
        _dayLabel.textColor = [UIColor colorWithRed:0.0/255.0 green:203.0/255.0 blue:0.0/255.0 alpha:1]; //Green Color
        _infinativeLabel.textColor = [UIColor blackColor];  //Black Color
        _todayLabel.text = @"Day";
    }
    
    else if ([_dayLabel.text isEqualToString:@""]) {
        _logoImage.hidden = FALSE;   //UNHide Logo
        _infinativeLabel.textColor = [UIColor clearColor]; //Set Lunch Color
        _dayLabel.textColor = [UIColor clearColor];  //clear Color
        _todayLabel.text = @""; //Set Text to ""
        _lunchday.textColor = [UIColor clearColor]; //Hide LunchDay
        
    }
    
        //Determine whether or not to get the lunch calendar
        
    if([_dayLabel.text isEqualToString: @"A" ] || [_dayLabel.text isEqualToString: @"B" ] || [_dayLabel.text isEqualToString: @"C" ] || [_dayLabel.text isEqualToString: @"D"]){
        
        //If A,B,C,D day; Get Lunch
        
        NSString *todaysLunch = [dayDict objectForKey:@"Lunch"];
        _lunchLabel.textColor = [UIColor blackColor];  //Black Color
        _lunchday.text = @"Lunch is";
        _lunchLabel.text = todaysLunch;
 
    }
    else{
        
        _lunchLabel.textColor = [UIColor clearColor];  //Black Color
        
    }
    

};
    


#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;    // Return the number of sections.

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [_EventArray count];    // Return the number of rows in the section.

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"homeCell";
    
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell with the textContent of the Post as the cell's text label
    
    GoogCal *eventLcl = (GoogCal *)[_EventArray objectAtIndex:[indexPath row]];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSLocale *locale = [NSLocale currentLocale];
    [dateFormat setLocale:locale];
    //[dateFormat setDateFormat:@"M/dd/yyyy"];
    [dateFormat setDateStyle:NSDateFormatterMediumStyle];
    
    NSString *startDateStr = [dateFormat stringFromDate:eventLcl.StartDate];
    
    cell.backgroundColor = [UIColor colorWithRed:237.0/255.0 green:242.0/255.0 blue:245.0/255.0 alpha:1];
    cell.textLabel.numberOfLines = 1;
    cell.textLabel.text = [NSString stringWithFormat:@"%@", eventLcl.Title ];
    cell.detailTextLabel.numberOfLines = 1;

    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@" ,startDateStr];
    
    return cell;
    
}


#pragma mark - Get GoogCal Data

-(void)LoadCalendarData {   //Calendar Data
    
    dispatch_sync(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL: kGoogleCalendarURL];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });
}

- (void)fetchedData:(NSData *)responseData {        //Fetched Calendar Data
    
    _EventArray = [[NSMutableArray alloc]init];
    
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    
    NSDictionary* latestLoans = [json objectForKey:@"feed"]; //2d
    NSArray* arrEvent = [latestLoans objectForKey:@"entry"];
    
    for (NSDictionary *event in arrEvent) {
        GoogCal *googCalObj = [[GoogCal alloc]init];
        
        NSDictionary *title = [event objectForKey:@"title"];
        googCalObj.Title = [title objectForKey:@"$t"];
        
        // Convert string to date object
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        NSLocale *enUSPOSIXLocale;
        enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        [dateFormat setLocale:enUSPOSIXLocale];
        [dateFormat setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
        [dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        
        NSArray *dateArr = [event objectForKey:@"gd$when"];     //dates are stored in an array

        
        for(NSDictionary *dateDict in dateArr) {
            
            NSLocale *enUSPOSIXLocale;
            enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            ISO8601DateFormatter *formatter = [[ISO8601DateFormatter alloc] init];
            
            NSDate *endDate = [formatter dateFromString:[dateDict objectForKey:@"endTime"]];
            NSDate *startDate = [formatter dateFromString:[dateDict objectForKey:@"startTime"]];
            formatter = nil;
            
            googCalObj.EndDate = endDate; //[endDate addTimeInterval:-3600*6];
            googCalObj.StartDate = startDate; //[startDate addTimeInterval:-3600*6];
            
        }
        
        NSDictionary *content = [event objectForKey:@"content"];
        googCalObj.Description = [content objectForKey:@"$t"];
        
        [_EventArray addObject:googCalObj];
        
    }
    
}

@end