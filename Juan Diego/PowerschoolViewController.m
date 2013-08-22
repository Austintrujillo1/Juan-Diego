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
    
    [self startWebViewLoad];
}


    //      ***************
    //      * Back Button *
    //      ***************


-(IBAction)backButtonPressed:(id)sender {
    [_webView goBack];
}


    //      ******************
    //      * Forward Button *
    //      ******************


-(IBAction)forwardButtonPressed:(id)sender
{
    [_webView goForward];
}


    //      *****************
    //      * Logout Button *
    //      *****************


- (IBAction)logoutButtonPressed:(id)sender
{
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://powerschool.slvcatholic.org/public/"]]];
}


    //      *************************
    //      * Start Loading WebView *
    //      *************************


-(void)startWebViewLoad
{
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://powerschool.slvcatholic.org/public/~loff"]]];}

- (void)webViewDidStartLoad:(UIWebView *)thisWebView
{
    _backButton.enabled = NO;
    _backButton.enabled = NO;
}


    //      ****************************
    //      * Finished Loading WebView *
    //      ****************************


- (void)webViewDidFinishLoad:(UIWebView *)thisWebView
{
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
