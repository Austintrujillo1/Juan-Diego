//
//  AssignmentsViewController.m
//  Juan Diego
//
//  Created by Austin Trujillo on 8/7/13.
//  Copyright (c) 2013 ATD. All rights reserved.
//

#import "AssignmentsViewController.h"
#import "AddAssignmentViewController.h"
#import <Parse/Parse.h>

@interface AssignmentsViewController ()

@end

@implementation AssignmentsViewController

@synthesize assignmentsArray;


    //      *******************
    //      * Init With Style *
    //      *******************


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


    //      *******************
    //      * View Did Appear *
    //      *******************


- (void) viewDidAppear:(BOOL)animated{
    
    [self refreshButton:nil];
}


    //      ********************
    //      * View Will Appear *
    //      ********************


- (void)viewWillAppear:(BOOL)animated {
    
    [self refreshButton:Nil];
    
}


    //      ******************
    //      * Refresh Button *
    //      ******************


- (IBAction)refreshButton:(id)sender{
    
    NSString *currentid = [[PFInstallation currentInstallation]deviceToken];
    
    PFQuery *assignmentQuery = [PFQuery queryWithClassName:@"Assignments"];
    
    [assignmentQuery whereKey:@"Identifier" equalTo:currentid];
    
    [assignmentQuery addAscendingOrder:@"Date"];
    
    [assignmentQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            assignmentsArray = objects;
            
            NSLog(@"%@", assignmentsArray);
            
            [self.tableView reloadData];
            
        }
    }];
    
    [self badgeIncrementer];
}


    //      **************************
    //      * Table View Data Source *
    //      **************************


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return assignmentsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell with the textContent of the Post as the cell's text label
    PFObject *assignments = [assignmentsArray objectAtIndex:indexPath.row];
    
    [cell.textLabel setText:[assignments objectForKey:@"Name"]];
    
    [cell.detailTextLabel setText:[assignments objectForKey:@"Description"]];
    
    [self badgeIncrementer];
    
    return cell;
    
}


    //      *********************
    //      * Badge Incrementer *
    //      *********************


- (void) badgeIncrementer{
    
    int indexICareAbout = 1;
    
    NSString *badgeValue = [NSString stringWithFormat:@"%d", assignmentsArray.count];
        
    [[[[[self tabBarController] viewControllers] objectAtIndex: indexICareAbout] tabBarItem] setBadgeValue:badgeValue];

}


    //      ***********************
    //      * Table Delete Button *
    //      ***********************


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

    PFObject *currentSelection = [self.assignmentsArray objectAtIndex:indexPath.row];
        
    [currentSelection deleteInBackground];
    
    [self performSelector:@selector(viewDidAppear:) withObject:nil afterDelay:1.0];
    
    [self refreshButton:nil];
    
}


@end
