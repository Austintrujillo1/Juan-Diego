//
//  homeViewController.m
//  Juan Diego
//
//  Created by Austin Trujillo on 8/2/13.
//  Copyright (c) 2013 ATD. All rights reserved.
//

#import "homeViewController.h"
#import "RSSLoader.h"


@interface homeViewController ()

@end

@implementation homeViewController

/*

//      **********************
//      * Init With Nib Name *
//      **********************


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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
	// Do any additional setup after loading the view.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (rss.loaded == YES) {
        return [rssItems count]*2;
    } else {
        return 1;
    }
}

//      ************************************************
//      * Customize The Appearence of Table View Cells *
//      ************************************************


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (rss.loaded == NO) {
        return [self getLoadingTableCellWithTableView:tableView];
    }
    
    if (indexPath.row % 2 == 1) {
        return [self getTextCellWithTableView:tableView atIndexPath:indexPath];
    }
    
    static NSString *CellIdentifier = @"TitleCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    UIView *backView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    backView.backgroundColor = [UIColor clearColor];
    cell.backgroundView = backView;
    
    NSDictionary* item = [rssItems objectAtIndex: indexPath.row/2];
    
    cell.textLabel.text = [item objectForKey:@"title"];
    
    return cell;
}

- (UITableViewCell *)getLoadingTableCellWithTableView:(UITableView *)tableView
{
    static NSString *LoadingCellIdentifier = @"LoadingCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LoadingCellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LoadingCellIdentifier] autorelease];
    }
    
    cell.textLabel.text = @"Loading...";
    
    UIActivityIndicatorView* activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [activity startAnimating];
    [cell setAccessoryView: activity];
    [activity release];
    
    return cell;
}

//      *********************************
//      * Get Text Cell With Table View *
//      *********************************


- (UITableViewCell *)getTextCellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    static NSString *TextCellIdentifier = @"TextCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TextCellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TextCellIdentifier] autorelease];
    }
    
    NSDictionary* item = [rssItems objectAtIndex: (indexPath.row-1)/2];
    
    //article preview
    cell.textLabel.font = [UIFont systemFontOfSize:11];
    cell.textLabel.numberOfLines = 3;
    cell.textLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    UIView *backView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    backView.backgroundColor = [UIColor clearColor];
    cell.backgroundView = backView;
    
    CGRect f = cell.textLabel.frame;
    [cell.textLabel setFrame: CGRectMake(f.origin.x+15, f.origin.y, f.size.width-15, f.size.height)];
    cell.textLabel.text = [item objectForKey:@"description"];
    
    return cell;
}

//      ***********************************
//      * View Did Recieve Memory Warning *
//      ***********************************



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 
*/

@end
