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


    //      ***********************
    //      * Start Web View Load *
    //      ***********************


-(void)startWebViewLoad
{
    //NSString *urlAddress = @"http://www.jdchs.org/pdfs/2012-2013_Parent_Student_Handbook.pdf";
    NSString *urlAddress = @"http://www.jdchs.org/pdfs/2012-2013_Parent_Student_Handbook.pdf";
    
    //Create a URL object.
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //Load the request in the UIWebView.
    [webView loadRequest:requestObj];
}


    //      ********************
    //      * Status Bar Style *
    //      ********************


-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


    //      *****************
    //      * View Did Load *
    //      *****************


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //call another method to do the webpage loading
    [self performSelector:@selector(startWebViewLoad) withObject:nil afterDelay:0];
}

@end