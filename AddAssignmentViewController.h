//
//  AddAssignmentViewController.h
//  Juan Diego
//
//  Created by Austin Trujillo on 8/7/13.
//  Copyright (c) 2013 ATD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddAssignmentViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *nameField;

@property (nonatomic, strong) IBOutlet UITextField *descriptionField;

@property (nonatomic, strong) IBOutlet UIDatePicker *datePicker;

@property (nonatomic, strong) NSArray *devIdArray;

- (IBAction)saveObject:(id)sender;

-(IBAction)cancelObject:(id)sender;

@end
