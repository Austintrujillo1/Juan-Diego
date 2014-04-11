//
//  PlannerTableViewController.h
//  Juan Diego
//
//  Created by Austin Trujillo on 9/17/13.
//  Copyright (c) 2013 ATD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlannerViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *assignmentsArray;

- (IBAction)addAssignment:(id)sender;

@end
