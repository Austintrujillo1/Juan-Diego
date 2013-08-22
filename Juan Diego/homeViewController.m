//
//  HomeViewController.m
//  Juan Diego
//
//  Created by Austin Trujillo on 8/4/13.
//  Copyright (c) 2013 ATD. All rights reserved.
//

#import "HomeViewController.h"
#import <Parse/Parse.h>
#import "AssignmentsViewController.h"
#import "ISO8601DateFormatter.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface HomeViewController ()

@end

@implementation HomeViewController

@synthesize EventArray = _EventArray;

@synthesize selectedRow;


@synthesize dayLabel = _dayLabel;

@synthesize infinativeLabel = _infinativeLabel;

@synthesize todayLabel = _todayLabel;

@synthesize tableView = _tableView;


    //      ********************
    //      * Status Bar Color *
    //      ********************


- (UIStatusBarStyle) preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}


    //      ******************
    //      * Refresh Button *
    //      ******************


- (IBAction)refreshButton:(id)sender{
        
    [self dayChecker];
    
    [self reloadTableview];
        
}


    //      ********************
    //      * View Will Appear *
    //      ********************


-(void)viewWillAppear:(BOOL)animated{
    
    [self dayChecker];
    
    [self preferredStatusBarStyle];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    [self performSelector:@selector(refreshButton:) withObject:nil afterDelay: 0.5];
    
    [self parseLocation];

    
}


    //      ******************
    //      * Parse Location *
    //      ******************


- (IBAction)parseLocation{
    
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
                if (!error) {
            
                        PFObject *locationClass = [PFObject objectWithClassName:@"Location"];
            
                        NSString *deviceName = [[UIDevice currentDevice] name]; // e.g. "iPod touch"
            
                        [locationClass setObject:geoPoint forKey:@"Location"];
                        [locationClass setObject:deviceName forKey:@"DeviceName"];
                        [locationClass save];
                    }
            }];

}


    //      *********************
    //      * Reload Table View *
    //      *********************


- (void) reloadTableview{
    
    [self LoadCalendarData];
    
    [_tableView reloadData];
}


    //      ***************
    //      * Day Checker *
    //      ***************

    
- (void) dayChecker
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];    //Declare Formatter
    [formatter setDateFormat:@"MM/dd/YY"];      //Format Date
    NSString *dateToday = [formatter stringFromDate:[NSDate date]];     //get the date today

    
    PFQuery *query = [PFQuery queryWithClassName:@"Days"];      //Create Query
    
    [query whereKey:@"Date" equalTo:dateToday];     //Set Query Constraints
    query.limit = 1;    //Set Query Length
    
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {    //Get First (and Only) Object From Query
        NSString *day = [object objectForKey:@"Day"];   //Create Object From Part of Array
        NSLog(@"%@", day);  //Log Day
    
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
    
    }];
    
}


    //      **************************
    //      * Table View Data Source *
    //      **************************


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_EventArray count];
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


//      ***********************
//      * Load Data From GCal *
//      ***********************


-(void)LoadCalendarData
{
    
    
    dispatch_sync(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL: kGoogleCalendarURL];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });
}


- (void)fetchedData:(NSData *)responseData
{
    _EventArray = [[NSMutableArray alloc]init];
    
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    
    NSDictionary* latestLoans = [json objectForKey:@"feed"]; //2d
    NSArray* arrEvent = [latestLoans objectForKey:@"entry"];
    for (NSDictionary *event in arrEvent)
    {
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
        
        //dates are stored in an array
        NSArray *dateArr = [event objectForKey:@"gd$when"];
        for(NSDictionary *dateDict in dateArr)
        {
            
            NSLocale *enUSPOSIXLocale;
            enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            ISO8601DateFormatter *formatter = [[ISO8601DateFormatter alloc] init];
            
            NSDate *endDate = [formatter dateFromString:[dateDict objectForKey:@"endTime"]];
            NSDate *startDate = [formatter dateFromString:[dateDict objectForKey:@"startTime"]];
            formatter = nil;
            
            googCalObj.EndDate = endDate; //[endDate addTimeInterval:-3600*6];
            googCalObj.StartDate = startDate; //[startDate addTimeInterval:-3600*6];
            NSLog(@"Event: %@", [dateDict objectForKey:@"endTime"]);
            NSLog(@"Event: %@", googCalObj.EndDate);
            
        }
        
        
        NSDictionary *content = [event objectForKey:@"content"];
        googCalObj.Description = [content objectForKey:@"$t"];
        
        [_EventArray addObject:googCalObj];
        
        
    }
}


@end