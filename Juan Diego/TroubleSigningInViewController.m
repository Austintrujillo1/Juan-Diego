//
//  TroubleSigningInViewController.m
//  Juan Diego
//
//  Created by Austin Trujillo on 8/2/13.
//  Copyright (c) 2013 ATD. All rights reserved.
//

#import "TroubleSigningInViewController.h"

@interface TroubleSigningInViewController ()

@end

@implementation TroubleSigningInViewController

@synthesize webView;
@synthesize back;
@synthesize forward;


    //      *************************
    //      * Method For Going Back *
    //      *************************


-(IBAction)backButtonPressed:(id)sender {
    [webView goBack];
}


    //      ****************************
    //      * Method For Going Forward *
    //      ****************************


-(IBAction)forwardButtonPressed:(id)sender
{
    [webView goForward];
}


    //      *****************
    //      * Load Web View *
    //      *****************


-(void)startWebViewLoad
{
    //NSString *urlAddress = @"https://powerschool.slvcatholic.org/public/account_recovery_begin.html";
    NSString *urlAddress = @"https://powerschool.slvcatholic.org/public/account_recovery_begin.html";
    
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


    //      ****************************************
    //      * Praga Mark UIWebViewDelegate Methods *
    //      ****************************************


#pragma mark UIWebViewDelegate methods


    //      **********************************************
    //      * Enable Or Disable Back And Forward Buttons *
    //      **********************************************


- (void)webViewDidStartLoad:(UIWebView *)thisWebView
{
    back.enabled = NO;
    forward.enabled = NO;
}


    //      *******************************
    //      * Web View Did Finish Loading *
    //      *******************************


- (void)webViewDidFinishLoad:(UIWebView *)thisWebView
{
    if(thisWebView.canGoBack == YES)
    {
        back.enabled = YES;
        back.highlighted = YES;
    }
    
    if(thisWebView.canGoForward == YES)
    {
        forward.enabled = YES;
        forward.highlighted = YES;
    }
}

@end
