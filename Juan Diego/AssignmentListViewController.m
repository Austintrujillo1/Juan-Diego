//
//  AssignmentListViewController.m
//  Juan Diego
//
//  Created by Austin Trujillo on 7/30/13.
//  Copyright (c) 2013 ATD. All rights reserved.
//

#import "AssignmentListViewController.h"
#import "Assignment.h"
#import "AddAssignmentViewController.h"
#import "EditAssignmentViewController.h"

@interface AssignmentListViewController ()

@end

@implementation AssignmentListViewController

@synthesize assignments = _assignments;


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


    //      *****************
    //      * View Did Load *
    //      *****************


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.assignments = [[NSMutableArray alloc] init];
    
    [self setNeedsStatusBarAppearanceUpdate];
    
}


    //      ******************************
    //      * Preferred Status Bar Style *
    //      ******************************


-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


    //      ******************************
    //      * Did Recieve Memory Warning *
    //      ******************************


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


    //      *********************
    //      * Prepare For Segue *
    //      *********************


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"AddAssignmentSegue"]) {
        UINavigationController *navCon = segue.destinationViewController;
        AddAssignmentViewController *addAssignmentViewController = [navCon.viewControllers objectAtIndex:0];
        addAssignmentViewController.assignmentListViewController = self;
    }
    else if ([segue.identifier isEqualToString:@"NotFinishedEditAssignmentSegue"] || [segue.identifier isEqualToString:@"FinishedEditAssignmentSegue"]){
        EditAssignmentViewController *editAssignmentViewController = segue.destinationViewController;
        editAssignmentViewController.assignment = [self.assignments objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    }
}


    //      ********************************
    //      * Table View Data Source Praga *
    //      ********************************


#pragma mark - Table view data source


    //      **************************************
    //      * Number of Selections in Table View *
    //      **************************************


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


    //      *******************************
    //      * Number Of Rows in Selection *
    //      *******************************


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.assignments.count;
}


    //      ******************************
    //      * Cell For Row At Index Path *
    //      ******************************


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *NotFinishedCellIdentifier = @"NotFinishedAssignmentCell";
    static NSString *FinishedCellIdentifier = @"FinishedAssignmentCell";
    
    Assignment *currentAssignment = [self.assignments objectAtIndex:indexPath.row];
    
    NSString *cellIdentifier = currentAssignment.done ? FinishedCellIdentifier : NotFinishedCellIdentifier;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell.textLabel.text = currentAssignment.assignmentName;
    cell.detailTextLabel.text = currentAssignment.assignmentDescription;
    
    return cell;
}


    //      ********************
    //      * View Will Appear *
    //      ********************


- (void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}


    //      *************************
    //      * Editing Of Table View *
    //      *************************


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        [self.assignments removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

@end
