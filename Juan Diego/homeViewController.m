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

@interface HomeViewController ()
@end


@implementation HomeViewController


@synthesize EventArray = _EventArray;
@synthesize LunchArray = _LunchArray;
@synthesize tableView = _tableView;
@synthesize activityView = _activityView;
@synthesize selectedRow;
@synthesize lunchday = _lunchday;
@synthesize dayLabel = _dayLabel;
@synthesize infinativeLabel = _infinativeLabel;
@synthesize todayLabel = _todayLabel;
@synthesize lunchLabel = _lunchLabel;


    //      ********************
    //      * Status Bar Color *
    //      ********************


- (UIStatusBarStyle) preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
    
}

    //      ******************
    //      * Refresh Button *
    //      ******************


- (IBAction)refreshButton:(id)sender {
    
    //Refresh Items
        
    [self dayChecker];
    [self LoadLunchData];
    [self preferredStatusBarStyle];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self reloadTableview];
    [self startActivityIndicator:nil];
    [self performSelector:@selector(stopActivityIndicator:) withObject:nil afterDelay: 0.9];
    
}


- (IBAction)startActivityIndicator:(id)sender{
    
    [_activityView startAnimating];     //Start Activity Indicator
    
}


- (IBAction)stopActivityIndicator:(id)sender{
    
    [_activityView stopAnimating];      //Stop Activity Indicator
}


-(void)viewWillAppear:(BOOL)animated {
    
    [_activityView startAnimating];
    
    [self performSelector:@selector(refreshButton:) withObject:nil afterDelay: 0.5];
    
}


- (void) reloadTableview {
    
    //Reload Table and Data
    
    [self LoadCalendarData];
    [_tableView reloadData];
    
}


- (void) dayChecker {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];    //Declare Formatter
    [formatter setDateFormat:@"MM/dd/YY"];      //Format Date
    NSString *dateToday = [formatter stringFromDate:[NSDate date]];     //get the date today
    
    PFQuery *query = [PFQuery queryWithClassName:@"Days"];      //Create Query
    
    [query whereKey:@"Date" equalTo:dateToday];     //Set Query Constraints
    query.limit = 1;    //Set Query Length
    
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {    //Get First (and Only) Object From Query
        NSString *day = [object objectForKey:@"Day"];   //Create Object From Part of Array
        NSLog(@"Day: %@", day);  //Log Day
    
    _dayLabel.text = day;   //Set Label To Day
    _todayLabel.text = @"Day";
    
    if ([_dayLabel.text isEqualToString:@"A"]) {    //A Day
        _infinativeLabel.text = @"Today is an"; //Infinative
        _dayLabel.textColor = [UIColor colorWithRed:244.0/255.0 green:136.0/255.0 blue:190.0/255.0 alpha:1]; //Pink Color
        _infinativeLabel.textColor = [UIColor blackColor];  //Black Color
        _todayLabel.text = @"Day";
    }
        
    else if ([_dayLabel.text isEqualToString:@"B"]) {   //B Day
        _infinativeLabel.text = @"Today is a";  //Infinative
        _dayLabel.textColor = [UIColor colorWithRed:73.0/255.0 green:134.0/255.0 blue:231.0/255.0 alpha:1]; //Blue Color
        _infinativeLabel.textColor = [UIColor blackColor];  //Black Color
        _todayLabel.text = @"Day";
    }
        
    else if ([_dayLabel.text isEqualToString:@"C"]) {   //C Day
        _infinativeLabel.text = @"Today is a";  //Infinative
        _dayLabel.textColor = [UIColor colorWithRed:255.0/255.0 green:204.0/255.0 blue:0.0/255.0 alpha:1]; //Yellow Color
        _infinativeLabel.textColor = [UIColor blackColor];  //Clear Color
        _todayLabel.text = @"Day";
    }
        
    else if ([_dayLabel.text isEqualToString:@"D"]) {   //D Day
        _infinativeLabel.text = @"Today is a";  //Infinative
        _dayLabel.textColor = [UIColor colorWithRed:0.0/255.0 green:203.0/255.0 blue:0.0/255.0 alpha:1]; //Green Color
        _infinativeLabel.textColor = [UIColor blackColor];  //Black Color
        _todayLabel.text = @"Day";
    }
        
    else if ([_dayLabel.text isEqualToString:@"No School"]) {   //No School
        _infinativeLabel.text = @"There is";    //Infinative
        _dayLabel.font = [UIFont systemFontOfSize:50.0];
        _dayLabel.textColor = [UIColor colorWithRed:248.0/255.0 green:58.0/255.0 blue:34.0/255.0 alpha:1];  //Red Color
        _infinativeLabel.textColor = [UIColor blackColor];  //Black Color
        _todayLabel.text = @"Today";
    }
        
    else if ([_dayLabel.text isEqualToString:@"Weekend"]){  //Weekend
        _dayLabel.textColor = [UIColor blackColor];  //Black Color
        _infinativeLabel.textColor = [UIColor blackColor];  //Black Color
        _infinativeLabel.text = @"It is the";
        _todayLabel.text = @"";
    }
        
        //Determine whether or not to get the lnch calendar
        
    if([_dayLabel.text isEqualToString: @"A" ] || [_dayLabel.text isEqualToString: @"B" ] || [_dayLabel.text isEqualToString: @"C" ] || [_dayLabel.text isEqualToString: @"D"]){
        
        //If A,B,C,D day; Get Lunch
        
        GoogCal *lunchLcl = (GoogCal *)[_LunchArray objectAtIndex:0];
        NSString *todaysLunch = lunchLcl.Title;
        _lunchday.text = @"Lunch is";
        _lunchLabel.text = todaysLunch;
            
            
    }
        
    else if ([_dayLabel.text isEqualToString: @"No School" ] || [_dayLabel.text isEqualToString: @"Weekend" ]){
        
        //If Weekend or No School
        
        _lunchLabel.text = @"";
        _lunchday.text = @"";
            
    }

    }];
    
}

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


-(void)LoadLunchData {      //Lunch Data
    
    dispatch_sync(kBgQueue, ^{
        NSData* lunchData = [NSData dataWithContentsOfURL: LunchURL];
        [self performSelectorOnMainThread:@selector(fetchedLunchData:) withObject:lunchData waitUntilDone:YES];
    });
}



- (void)fetchedLunchData:(NSData *)responseData {       //Fetched Lunch Data
    
    _LunchArray = [[NSMutableArray alloc]init];
    
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
        NSLog(@"Lunch: %@", googCalObj.Title);
        
        // Convert string to date object
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        NSLocale *enUSPOSIXLocale;
        enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        [dateFormat setLocale:enUSPOSIXLocale];
        [dateFormat setDateFormat:@"yyyy'-'MM'-'dd'T'Z'"];
        [dateFormat setDateFormat:@"'EEEE'"];
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
        
        [_LunchArray addObject:googCalObj];
        
    }
    
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
        NSLog(@"Event: %@", googCalObj.Title);
        
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