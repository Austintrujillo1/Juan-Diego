//
//  AssignmentsViewController.h
//  Juan Diego
//
//  Created by Austin Trujillo on 8/7/13.
//  Copyright (c) 2013 ATD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AssignmentsViewController : UITableViewController

@property (nonatomic, strong) NSArray *assignmentsArray;

- (IBAction)refreshButton:(id)sender;

@end
 