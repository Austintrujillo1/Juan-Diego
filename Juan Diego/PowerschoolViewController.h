//
//  PowerschoolViewController.h
//  Juan Diego
//
//  Created by Austin Trujillo on 8/14/13.
//  Copyright (c) 2013 ATD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PowerschoolViewController : UIViewController <UIWebViewDelegate>{
    
    UIWebView *webView;
    
    UIBarButtonItem *back;
    
    UIBarButtonItem *forward;
    
    UIBarButtonItem *logout;
}

@property (nonatomic, strong) IBOutlet UIWebView *webView;

@property (nonatomic, strong) IBOutlet UIBarButtonItem *backButton;

@property (nonatomic, strong) IBOutlet UIBarButtonItem *forwardButton;

@property (nonatomic, strong) IBOutlet UIBarButtonItem *logoutButton;

-(IBAction)backButtonPressed: (id)sender;

-(IBAction)forwardButtonPressed: (id)sender;

- (IBAction)logoutButtonPressed:(id)sender;

@end
