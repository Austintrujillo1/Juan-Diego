//
//  Day.m
//  Juan Diego
//
//  Created by Austin Trujillo on 10/17/13.
//  Copyright (c) 2013 ATD. All rights reserved.
//

#import "Day.h"
#import "ISO8601DateFormatter.h"
#import <Parse/Parse.h>
#import <MapKit/MapKit.h>
#import "HomeViewController.h"

@implementation Day

@synthesize aDayArray = _aDayArray;
@synthesize bDayArray = _bDayArray;
@synthesize cDayArray = _cDayArray;
@synthesize dDayArray = _dDayArray;
@synthesize lunchArray = _lunchArray;

@synthesize ADateDict;
@synthesize BDateDict;
@synthesize CDateDict;
@synthesize DDateDict;
@synthesize lunchDict;

@synthesize indexInt;

@synthesize todayString = _todayString;

- (NSString *) dataFilePath {
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentDirectory = [path objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"Today.plist"];
    
}

- (void) loadAllData {
        
    [self LoadAData];
    [self LoadBData];
    [self LoadCData];
    [self LoadDData];
    [self LoadLunchData];
    
    [self logData:nil];
    
}

#pragma mark - Get GoogCal Data

-(void)LoadAData {   //Calendar Data
    
    dispatch_sync(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL: ADayCalendar];
        [self performSelectorOnMainThread:@selector(fetchedAData:) withObject:data waitUntilDone:YES];
    });
}
-(void)LoadBData {      //Lunch Data
    
    dispatch_sync(kBgQueue, ^{
        NSData* lunchData = [NSData dataWithContentsOfURL: BDayCalendar];
        [self performSelectorOnMainThread:@selector(fetchedBData:) withObject:lunchData waitUntilDone:YES];
    });
}
-(void)LoadCData {   //Calendar Data
    
    dispatch_sync(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL: CDayCalendar];
        [self performSelectorOnMainThread:@selector(fetchedCData:) withObject:data waitUntilDone:YES];
    });
}
-(void)LoadDData {      //Lunch Data
    
    dispatch_sync(kBgQueue, ^{
        NSData* lunchData = [NSData dataWithContentsOfURL: DDayCalendar];
        [self performSelectorOnMainThread:@selector(fetchedDData:) withObject:lunchData waitUntilDone:YES];
    });
}
-(void)LoadLunchData {      //Lunch Data
    
    dispatch_sync(kBgQueue, ^{
        NSData* lunchData = [NSData dataWithContentsOfURL: LunchURL];
        [self performSelectorOnMainThread:@selector(fetchedLunchData:) withObject:lunchData waitUntilDone:YES];
    });
}

- (void)fetchedLunchData:(NSData *)responseData {       //Fetched Lunch Data
    
    _lunchArray = [[NSMutableArray alloc]init];
    
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
        
        NSArray *dateArr = [event objectForKey:@"gd$when"];
        
        for(ADateDict in dateArr) {
            
            googCalObj.Date = [ADateDict objectForKey:@"startTime"];
            
        }
        
        NSDictionary *content = [event objectForKey:@"content"];
        googCalObj.Description = [content objectForKey:@"$t"];
        
        [_lunchArray addObject:googCalObj];
        
    }
    
}
- (void)fetchedAData:(NSData *)responseData {       //Fetched Lunch Data
    
    _aDayArray = [[NSMutableArray alloc]init];
    
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
        
        NSArray *dateArr = [event objectForKey:@"gd$when"];
        
        for(ADateDict in dateArr) {
            
            googCalObj.Date = [ADateDict objectForKey:@"startTime"];
            
        }
        
        NSDictionary *content = [event objectForKey:@"content"];
        googCalObj.Description = [content objectForKey:@"$t"];
        
        [_aDayArray addObject:googCalObj];
                
    }
    
}
- (void)fetchedBData:(NSData *)responseData {       //Fetched Lunch Data
    
    _bDayArray = [[NSMutableArray alloc]init];
    
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
        
        NSArray *dateArr = [event objectForKey:@"gd$when"];
        
        for(BDateDict in dateArr) {
            
            googCalObj.Date = [BDateDict objectForKey:@"startTime"];
            
        }
        
        NSDictionary *content = [event objectForKey:@"content"];
        googCalObj.Description = [content objectForKey:@"$t"];
        
        [_bDayArray addObject:googCalObj];
        
    }
    
}
- (void)fetchedCData:(NSData *)responseData {       //Fetched Lunch Data
    
    _cDayArray = [[NSMutableArray alloc]init];
    
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
        
        NSArray *dateArr = [event objectForKey:@"gd$when"];
        
        for(CDateDict in dateArr) {
            
            googCalObj.Date = [CDateDict objectForKey:@"startTime"];
            
        }
        
        NSDictionary *content = [event objectForKey:@"content"];
        googCalObj.Description = [content objectForKey:@"$t"];
        
        [_cDayArray addObject:googCalObj];
        
    }
    
}
- (void)fetchedDData:(NSData *)responseData {       //Fetched Lunch Data
    
    _dDayArray = [[NSMutableArray alloc]init];
    
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
        
        NSArray *dateArr = [event objectForKey:@"gd$when"];
        
        for(DDateDict in dateArr) {
            
            googCalObj.Date = [DDateDict objectForKey:@"startTime"];
            
        }
        
        NSDictionary *content = [event objectForKey:@"content"];
        googCalObj.Description = [content objectForKey:@"$t"];
        
        [_dDayArray addObject:googCalObj];
        
    }
    
}

- (IBAction)logData:(id)sender{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];    //Declare Formatter
    [formatter setDateFormat:@"YYYY-MM-dd"];      //Format Date
    NSString *dateToday = [formatter stringFromDate:[NSDate date]];     //get the date today
        
    NSLog(@"Today: %@", dateToday);
    
    GoogCal *AEventLcl = (GoogCal *)[_aDayArray objectAtIndex:0];
    GoogCal *BEventLcl = (GoogCal *)[_bDayArray objectAtIndex:0];
    GoogCal *CEventLcl = (GoogCal *)[_cDayArray objectAtIndex:0];
    GoogCal *DEventLcl = (GoogCal *)[_dDayArray objectAtIndex:0];
    GoogCal *LunchEventLcl = (GoogCal *)[_lunchArray objectAtIndex:0];
    
    NSLog(@"A EVENT: %@", AEventLcl.Date);
    NSLog(@"B EVENT: %@", BEventLcl.Date);
    NSLog(@"C EVENT: %@", CEventLcl.Date);
    NSLog(@"D EVENT: %@", DEventLcl.Date);
    NSLog(@"Lunch Event: %@", LunchEventLcl.Title);
    
    NSString *todayString;
    
    if ([AEventLcl.Date isEqualToString: dateToday]) {
        
        NSLog(@"A Title: %@", AEventLcl.Title);
        
        todayString = AEventLcl.Title;
        
    }
    else if ([BEventLcl.Date isEqualToString: dateToday]){
        
        NSLog(@"B Title: %@", BEventLcl.Title);

        todayString = BEventLcl.Title;

    }
    else if ([CEventLcl.Date isEqualToString: dateToday]){

        NSLog(@"C Title: %@", CEventLcl.Title);
        
        todayString = CEventLcl.Title;


    }
    else if ([DEventLcl.Date isEqualToString: dateToday]){

        NSLog(@"D Title: %@", DEventLcl.Title);
        
        todayString = DEventLcl.Title;

    }
    else{
        
        todayString = @"";
        
        NSLog(@"IT DIDN'T WORK!");
        
        
    }
    
    NSMutableDictionary *plistToWrite = [NSMutableDictionary dictionary];
    [plistToWrite setObject:LunchEventLcl.Title forKey:@"Lunch"];
    [plistToWrite setObject:todayString forKey:@"Today"];
    [plistToWrite setObject:dateToday forKey:@"Date"];

    [plistToWrite writeToFile:[self dataFilePath] atomically:YES];
    
}

@end