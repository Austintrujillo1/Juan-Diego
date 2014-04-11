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

- (IBAction)facebookIntegration:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"fb://profile/310627345673242"]];      //Open Facebook app with profile
}


- (IBAction)youtubeIntegration:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.youtube.com/channel/UCZ6a-KF00z6qW9Xi1WK1k8g"]];       //Open Safari at youtube channel

}


- (IBAction)twitterIntegration:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?screen_name=JDCHS"]];      //Open Twitter app with profile
}


- (IBAction)instagramIntegration:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"instagram://user?username=JDCHS"]];       //Open Instagram app with profile
}


@end
