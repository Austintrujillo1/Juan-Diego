//
//  HandbookViewController.m
//  Juan Diego
//
//  Created by Austin Trujillo on 7/31/13.
//  Copyright (c) 2013 ATD. All rights reserved.
//

#import "HandbookViewController.h"

@interface HandbookViewController ()

@end

@implementation HandbookViewController

@synthesize webView;

-(void)startWebViewLoad
{
    //Path to PDF
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Handbook" ofType:@"pdf"];
    
    //Create a URL object.
    NSURL *url = [NSURL fileURLWithPath:path];
    
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //Load the request in the UIWebView.
    [webView loadRequest:requestObj];
}


-(UIStatusBarStyle)preferredStatusBarStyle{

    return UIStatusBarStyleLightContent;        //Light Status Bar

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //call another method to do the webpage loading
    [self performSelector:@selector(startWebViewLoad) withObject:nil afterDelay:0];

}

@end