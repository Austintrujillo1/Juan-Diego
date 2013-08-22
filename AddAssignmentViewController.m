//
//  AddAssignmentViewController.m
//  Juan Diego
//
//  Created by Austin Trujillo on 8/7/13.
//  Copyright (c) 2013 ATD. All rights reserved.
//

#import "AddAssignmentViewController.h"
#import "AssignmentsViewController.h"
#import <Parse/Parse.h>

@interface AddAssignmentViewController ()

@end

@implementation AddAssignmentViewController

@synthesize nameField = _nameField;

@synthesize descriptionField = _descriptionField;

@synthesize datePicker = _datePicker;

@synthesize devIdArray;


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
    
    [_nameField becomeFirstResponder];

    
    AssignmentsViewController *refresh = [[AssignmentsViewController alloc]init];
    
    [refresh refreshButton:nil];
    
}


    //      *********************
    //      * Cancel Assignment *
    //      *********************


-(IBAction)cancelObject:(id)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


    //      *******************
    //      * Save Assignment *
    //      *******************


- (IBAction)saveObject:(id)sender{
    
    NSString *currentid = [[PFInstallation currentInstallation]deviceToken];
    
    PFObject *assignments = [PFObject objectWithClassName:@"Assignments"];
    [assignments setObject: currentid forKey:@"Identifier"];
    [assignments setObject:_nameField.text forKey:@"Name"];
    [assignments setObject:_descriptionField.text forKey:@"Description"];
    [assignments setObject:_datePicker.date forKey:@"Date"];
    
    [assignments saveInBackground];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
