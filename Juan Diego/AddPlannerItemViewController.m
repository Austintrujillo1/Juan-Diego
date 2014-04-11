//
//  AddPlannerItemViewController.m
//  Juan Diego
//
//  Created by Austin Trujillo on 9/18/13.
//  Copyright (c) 2013 ATD. All rights reserved.
//

#import "AddPlannerItemViewController.h"

@interface AddPlannerItemViewController ()

@end

@implementation AddPlannerItemViewController

@synthesize nameField = _nameField;
@synthesize descriptionField = _descriptionField;
@synthesize indexInt;
@synthesize assignmentsArray;
@synthesize previousAssignments;

- (NSString *) dataFilePath {
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentDirectory = [path objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"Assignments.plist"];

}
- (void) viewWillAppear:(BOOL)animated{
    
    NSString *filePath = [self dataFilePath];
    
    assignmentsArray = [NSMutableArray arrayWithCapacity:20];
    previousAssignments = [NSArray arrayWithContentsOfFile:filePath];
    [assignmentsArray addObjectsFromArray:previousAssignments];
        
    NSLog(@"%@", assignmentsArray);
    NSLog(@"%lu", (unsigned long)assignmentsArray.count);

    [self.nameField becomeFirstResponder];
    
}

- (IBAction)saveItem:(id)sender{
    
    NSMutableDictionary *plistToWrite = [NSMutableDictionary dictionary];
    [plistToWrite setObject:_nameField.text forKey:@"Name"];
    [plistToWrite setObject:_descriptionField.text forKey:@"Description"];
    
    [assignmentsArray insertObject:plistToWrite atIndex:assignmentsArray.count];
    [assignmentsArray writeToFile:[self dataFilePath] atomically:NO];

    [self.navigationController popToRootViewControllerAnimated:YES];

}


@end