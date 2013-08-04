//
//  TroubleSigningInViewController.h
//  Juan Diego
//
//  Created by Austin Trujillo on 8/2/13.
//  Copyright (c) 2013 ATD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TroubleSigningInViewController : UIViewController <UIWebViewDelegate>
{
    UIWebView *webView;
    UIButton *back;
    UIButton *forward;
}

@property(nonatomic,retain)IBOutlet UIWebView *webView;
@property(nonatomic,retain)IBOutlet UIButton *back;
@property(nonatomic,retain)IBOutlet UIButton *forward;

-(IBAction)backButtonPressed: (id)sender;
-(IBAction)forwardButtonPressed: (id)sender;

@end
