//
//  PlannerTableViewController.m
//  Juan Diego
//
//  Created by Austin Trujillo on 9/17/13.
//  Copyright (c) 2013 ATD. All rights reserved.
//

#import "PlannerViewController.h"

@interface PlannerViewController ()

@end

@implementation PlannerViewController
@synthesize assignmentsArray;

- (NSString *) dataFilePath {
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentDirectory = [path objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"Assignments.plist"];
}

- (void) viewWillAppear:(BOOL)animated {
    
    NSString *filePath = [self dataFilePath];
    
    assignmentsArray = [NSMutableArray arrayWithContentsOfFile:filePath];
    
    [self.tableView reloadData];

}

- (IBAction)addAssignment:(id)sender{
    
    [self performSegueWithIdentifier:@"addSegue" sender:self];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1; // Return the number of sections.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //    return assignmentsDictionary.count;    // Return the number of rows in the section.
    
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
    
    cell.textLabel.text = [[assignmentsArray objectAtIndex:indexPath.row] objectForKey:@"Name"];
    
    cell.detailTextLabel.text = [[assignmentsArray objectAtIndex:indexPath.row] objectForKey:@"Description"];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        NSString *filePath = [self dataFilePath];
        
        [assignmentsArray removeObjectAtIndex:indexPath.row];
        
        [assignmentsArray writeToFile:filePath atomically:NO];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

@end
