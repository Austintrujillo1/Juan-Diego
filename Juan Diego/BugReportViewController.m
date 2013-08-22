//
//  BugReportViewController.m
//  Juan Diego
//
//  Created by Austin Trujillo on 8/13/13.
//  Copyright (c) 2013 ATD. All rights reserved.
//

#import "BugReportViewController.h"
#import <Parse/Parse.h>

@interface BugReportViewController ()

@end

@implementation BugReportViewController

@synthesize subjectField = _subjectField;
@synthesize descriptionField = _descriptionField;
@synthesize sendButton = _sendButton;

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
	// Do any additional setup after loading the view.
    
    [_subjectField becomeFirstResponder];
}

- (IBAction)sendBug:(id)sender{
    
    NSString *currentid = [[PFInstallation currentInstallation]deviceToken];
    
    PFObject *tip = [PFObject objectWithClassName:@"Bugs"];
    [tip setObject: currentid forKey:@"Identifier"];
    [tip setObject:_subjectField.text forKey:@"Subject"];
    [tip setObject:_descriptionField.text forKey:@"Description"];
    
    [tip saveInBackground];
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: @"Thank You"
                          message: @"Bug Report Sent!"
                          delegate: nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [alert show];
    
    
}


@end
