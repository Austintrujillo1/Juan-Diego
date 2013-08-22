//
//  BugReportViewController.h
//  Juan Diego
//
//  Created by Austin Trujillo on 8/13/13.
//  Copyright (c) 2013 ATD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BugReportViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *subjectField;

@property (strong, nonatomic) IBOutlet UITextView *descriptionField;

@property (strong, nonatomic) IBOutlet UIButton *sendButton;

- (IBAction)sendBug:(id)sender;

@end
