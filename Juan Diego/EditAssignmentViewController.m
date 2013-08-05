//
//  EditAssignmentViewController.m
//  Juan Diego
//
//  Created by Austin Trujillo on 7/30/13.
//  Copyright (c) 2013 ATD. All rights reserved.
//

#import "EditAssignmentViewController.h"
#import "Assignment.h"

@interface EditAssignmentViewController ()

@end

@implementation EditAssignmentViewController

@synthesize AssignmentNameField = _AssignmentNameField;
@synthesize AssignmentDescriptionField = _AssignmentDescriptionField;
@synthesize doneSwitch = _doneSwitch;
@synthesize assignment = _assignment;


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
    
    self.navigationItem.title = self.assignment.assignmentName;
    
    self.AssignmentNameField.text = self.assignment.assignmentName;
    self.AssignmentDescriptionField.text = self.assignment.assignmentDescription;
    [self.doneSwitch setOn:self.assignment.done];
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


    //      ********************************
    //      * Assignment Text Data Changed *
    //      ********************************


- (void)assignmentDataChanged:(id)sender{
    
    self.assignment.assignmentName = self.AssignmentNameField.text;
    self.assignment.assignmentDescription = self.AssignmentDescriptionField.text;
    
}

//      **********************************
//      * Assignment Switch Data Changed *
//      **********************************

- (void) switchStatus:(id)sender{
    
    if ([_doneSwitch isOn]) {
        self.assignment.done = YES;
    }
    else{
        self.assignment.done = NO;
    }
}

@end
