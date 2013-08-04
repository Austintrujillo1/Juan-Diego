//
//  Assignment.m
//  Juan Diego
//
//  Created by Austin Trujillo on 7/30/13.
//  Copyright (c) 2013 ATD. All rights reserved.
//

#import "Assignment.h"

@implementation Assignment

@synthesize assignmentName = _assignmentName;
@synthesize assignmentDescription = _assignmentDescription;
@synthesize done = _done;

    //      *****************
    //      * Init With Name *
    //      *****************


- (id)initWithName:(NSString *)assignmentName assignmentDescription:(NSString *)assignmentDescription done:(BOOL)done{
    self = [super init];
    
    if (self) {
        self.assignmentName = assignmentName;
        self.assignmentDescription = assignmentDescription;
        self.done = done;
    }
    
    return self;
    
}

@end
