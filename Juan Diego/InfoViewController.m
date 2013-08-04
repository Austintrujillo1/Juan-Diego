//
//  InfoViewController.m
//  Juan Diego
//
//  Created by Austin Trujillo on 8/1/13.
//  Copyright (c) 2013 ATD. All rights reserved.
//

#import "InfoViewController.h"
#import <MapKit/MapKit.h>
#define METERS_PER_MILE 1609


@interface InfoViewController ()

@end

@implementation InfoViewController


    //      **********************
    //      * Init With Nib Name *
    //      **********************


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}


    //      ***************
    //      * Call Office *
    //      ***************


-(IBAction)callOffice:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://8019847650"]];
}


    //      *****************
    //      * Call Absentee *
    //      *****************


-(IBAction)callAbsentee:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://8019847648"]];
}


    //      ********************
    //      * View Will Appear *
    //      ********************


- (void)viewWillAppear:(BOOL)animated{
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 40.535521;
    zoomLocation.longitude= -111.881579;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
    [_mapView setRegion:viewRegion animated:YES];
}


    //      ******************************
    //      * Did Recieve Memory Warning *
    //      ******************************


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
