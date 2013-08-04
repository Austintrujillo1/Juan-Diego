//
//  Assignment.h
//  Juan Diego
//
//  Created by Austin Trujillo on 7/30/13.
//  Copyright (c) 2013 ATD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Assignment : NSObject

@property (nonatomic, strong) NSString *assignmentName;
@property (nonatomic, strong) NSString *assignmentDescription;
@property (nonatomic, assign) BOOL done;

- (id)initWithName:(NSString *)assignmentName assignmentDescription:(NSString *)assignmentDescription done:(BOOL)done;



@end
