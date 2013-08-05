//
//  EditAssignmentViewController.h
//  Juan Diego
//
//  Created by Austin Trujillo on 7/30/13.
//  Copyright (c) 2013 ATD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Assignment;

@interface EditAssignmentViewController : UIViewController

@property(nonatomic, strong) IBOutlet UITextField *AssignmentNameField;
@property(nonatomic, strong) IBOutlet UITextField *AssignmentDescriptionField;
@property(nonatomic, strong) IBOutlet UISwitch *doneSwitch;

@property(nonatomic, strong) Assignment *assignment;

- (IBAction) assignmentDataChanged:(id)sender;

- (IBAction) switchStatus:(id)sender;


@end
