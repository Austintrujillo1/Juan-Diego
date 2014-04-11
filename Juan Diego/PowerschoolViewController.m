//
//  PowerschoolViewController.m
//  Juan Diego
//
//  Created by Austin Trujillo on 8/14/13.
//  Copyright (c) 2013 ATD. All rights reserved.
//

#import "PowerschoolViewController.h"

@interface PowerschoolViewController ()

@end

@implementation PowerschoolViewController

@synthesize webView = _webView;

@synthesize backButton = _backButton;

@synthesize forwardButton = _forwardButton;

@synthesize logoutButton = _logoutButton;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self startWebViewLoad];    //Start Loading WebView
}


-(IBAction)backButtonPressed:(id)sender {
   
    [_webView goBack];      //Go Back in WebView via Button
}


-(IBAction)forwardButtonPressed:(id)sender{
    
    [_webView goForward];       //Go Forward in WebView via Button
}


- (IBAction)logoutButtonPressed:(id)sender{
   
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://powerschool.slvcatholic.org/public/"]]];      //Log Out of the current Powerschool Session
}


-(void)startWebViewLoad{
 
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://powerschool.slvcatholic.org/public/~loff"]]];     //Start Loading
}

- (void)webViewDidStartLoad:(UIWebView *)thisWebView{
   
    _backButton.enabled = NO;       //Disable Back Button
}


- (void)webViewDidFinishLoad:(UIWebView *)thisWebView
{
    //Enable buttons
    
    if(thisWebView.canGoBack == YES)
    {
        _backButton.enabled = YES;
    }
    
    if(thisWebView.canGoForward == YES)
    {
        _forwardButton.enabled = YES;
    }
}


@end
