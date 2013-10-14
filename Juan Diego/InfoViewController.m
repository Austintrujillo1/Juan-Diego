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


- (void)viewDidLoad
{
    [super viewDidLoad];
    
}


-(IBAction)callOffice:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://8019847650"]];        //Open Prompt; Open Phone; Call 8019847650
}


-(IBAction)callAbsentee:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://8019847648"]];        //Open Prompt; Open Phone; Call 8019847648
}


- (void)viewWillAppear:(BOOL)animated{
    
    CLLocationCoordinate2D zoomLocation;        //Zoom Location
    zoomLocation.latitude = 40.535521;          //Latitude
    zoomLocation.longitude= -111.881579;        //Longitude
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);     //Region
    
    //Create Point
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    [point setCoordinate:zoomLocation];     //Set Coordinate
    [point setTitle:@"Juan Diego Catholic High School"];        //Set Title
    
    [_mapView addAnnotation:point];     //Add Anotation to mapView
    
    [_mapView setRegion:viewRegion animated:YES];       //set region
    
    [_mapView selectAnnotation:point animated:YES];     //Drop Point

}

@end
