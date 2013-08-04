//
//  AddAssignmentViewController.h
//  Juan Diego
//
//  Created by Austin Trujillo on 7/30/13.
//  Copyright (c) 2013 ATD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AssignmentListViewController;

@interface AddAssignmentViewController : UIViewController

- (IBAction)cancelButtonPressed:(id)sender;
- (IBAction)saveButtonPressed:(id)sender;

@property(nonatomic, strong) IBOutlet UITextField *assignmentNameField;
@property(nonatomic, strong) IBOutlet UITextField *assignmentDescriptionField;

@property (nonatomic, strong) AssignmentListViewController *assignmentListViewController;



@end
