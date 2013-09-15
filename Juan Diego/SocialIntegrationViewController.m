//
//  SocialIntegrationViewController.m
//  Juan Diego
//
//  Created by Austin Trujillo on 8/2/13.
//  Copyright (c) 2013 ATD. All rights reserved.
//


#import "SocialIntegrationViewController.h"

@interface SocialIntegrationViewController ()

@end

@implementation SocialIntegrationViewController


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


    //      *****************
    //      * View Did Load *
    //      *****************


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


    //      ************************
    //      * Facebook Integration *
    //      ************************


- (IBAction)facebookIntegration:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"fb://profile/310627345673242"]];
}


//      ************************
//      * Facebook Integration *
//      ************************


- (IBAction)youtubeIntegration:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.youtube.com/channel/UCZ6a-KF00z6qW9Xi1WK1k8g"]];

}


    //      ***********************
    //      * Twitter Integration *
    //      ***********************


- (IBAction)twitterIntegration:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?screen_name=JDCHS"]];
}


    //      *************************
    //      * Instagram Integration *
    //      *************************


- (IBAction)instagramIntegration:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"instagram://user?username=JDCHS"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
