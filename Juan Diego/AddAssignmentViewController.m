//
//  AddAssignmentViewController.m
//  Juan Diego
//
//  Created by Austin Trujillo on 7/30/13.
//  Copyright (c) 2013 ATD. All rights reserved.
//

#import "AddAssignmentViewController.h"
#import "AssignmentListViewController.h"
#import "Assignment.h"

@interface AddAssignmentViewController ()

@end

@implementation AddAssignmentViewController

@synthesize assignmentNameField = _assignmentNameField;
@synthesize assignmentDescriptionField = _assignmentDescriptionField;
@synthesize assignmentListViewController = _assignmentListViewController;


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
    
    [_assignmentNameField becomeFirstResponder];
}


    //      ******************************
    //      * Did Recieve Memory Warning *
    //      ******************************


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


    //      ************************
    //      * Praga Mark IBActions *
    //      ************************


#pragma mark - IBActions


    //      *************************
    //      * Cancel Button Pressed *
    //      *************************


- (void) cancelButtonPressed:(id)sender{
    [self dismissViewControllerAnimated:NO completion:nil];
}


    //      ***********************
    //      * Save Button Pressed *
    //      ***********************


- (void) saveButtonPressed: (id)sender{

    Assignment *newAssignment = [[Assignment alloc]initWithName:self.assignmentNameField.text assignmentDescription:self.assignmentDescriptionField.text done:NO];
    
    [self.assignmentListViewController.assignments addObject:newAssignment];
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
}

@end
