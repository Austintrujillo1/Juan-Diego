//
//  AddPlannerItemViewController.h
//  Juan Diego
//
//  Created by Austin Trujillo on 9/18/13.
//  Copyright (c) 2013 ATD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddPlannerItemViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *nameField;

@property (nonatomic, strong) IBOutlet UITextField *descriptionField;

@property (nonatomic, strong) NSMutableArray *assignmentsArray;

@property (nonatomic, strong) NSArray *previousAssignments;

@property (nonatomic) NSUInteger *indexInt;

- (IBAction)saveItem:(id)sender;

@end
