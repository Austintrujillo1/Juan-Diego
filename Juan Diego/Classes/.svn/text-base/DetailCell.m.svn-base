//
//  DetailCell.m
//  GoogleCalendar
//
//  Created by Dan Bourque on 4/30/09.
//  Copyright Dan Bourque 2009. All rights reserved.
//
#import "DetailCell.h"

@implementation DetailCell

@synthesize date, time, name, addr, prompt, promptMode;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier{
  if( self=[super initWithFrame:frame reuseIdentifier:reuseIdentifier] ){
    // Initialize the labels, their fonts, colors, alignment, and background color.
    date = [[UILabel alloc] initWithFrame:CGRectZero];
    date.font = [UIFont boldSystemFontOfSize:12];
    date.textColor = [UIColor darkGrayColor];
    date.textAlignment = UITextAlignmentRight;
    date.backgroundColor = [UIColor clearColor];
    
    time = [[UILabel alloc] initWithFrame:CGRectZero];
    time.font = [UIFont boldSystemFontOfSize:12];
    time.textColor = [UIColor darkGrayColor];
    time.textAlignment = UITextAlignmentRight;
    time.backgroundColor = [UIColor clearColor];
    
    name = [[UILabel alloc] initWithFrame:CGRectZero];
    name.font = [UIFont boldSystemFontOfSize:14];
    name.backgroundColor = [UIColor clearColor];
    
    addr = [[UILabel alloc] initWithFrame:CGRectZero];
    addr.font = [UIFont boldSystemFontOfSize:10];
    addr.textColor = [UIColor darkGrayColor];
    addr.backgroundColor = [UIColor clearColor];
    
    prompt = [[UILabel alloc] initWithFrame:CGRectZero];
    prompt.font = [UIFont boldSystemFontOfSize:12];
    prompt.textColor = [UIColor darkGrayColor];
    prompt.backgroundColor = [UIColor clearColor];

    // Add the labels to the content view of the cell.

    // Important: although UITableViewCell inherits from UIView, you should add subviews to its content view
    // rather than directly to the cell so that they will be positioned appropriately as the cell transitions 
    // into and out of editing mode.

    [self.contentView addSubview:date];
    [self.contentView addSubview:time];
    [self.contentView addSubview:name];
    [self.contentView addSubview:addr];
    [self.contentView addSubview:prompt];
//    self.autoresizesSubviews = YES;
  }
  return self;
}

- (void)dealloc{
  [date release];
  [time release];
  [name release];
  [addr release];
  [prompt release];
  [super dealloc];
}

- (void)setPromptMode:(BOOL)flag{  // Setting the prompt mode to YES hides the date/time/name/addr labels and shows the prompt label.
  if( flag ){
    date.hidden = YES;
    time.hidden = YES;
    name.hidden = YES;
    addr.hidden = YES;
    prompt.hidden = NO;
  }else{
    date.hidden = NO;
    time.hidden = NO;
    name.hidden = NO;
    addr.hidden = NO;
    prompt.hidden = YES;
  }
}

- (void)layoutSubviews{
  [super layoutSubviews];
  // Start with a rect that is inset from the content view by 10 pixels on all sides.
  CGRect baseRect = CGRectInset( self.contentView.bounds, 10, 10 );
  CGRect rect = baseRect;
  
  // Position each label with a modified version of the base rect.
  rect.origin.x += 15;
  prompt.frame = rect;

  // First column...
  rect.size.width = 50;
  rect.origin.x -= 15;
  rect.origin.y -= 7;
  date.frame = rect;
  rect.origin.y += 15;
  time.frame = rect;

  // Second column...
  rect.size.width = baseRect.size.width - 60;
  rect.origin.x += 60;
  rect.origin.y -= 15;
  name.frame = rect;
  rect.origin.y += 14;
  addr.frame = rect;
}

// Update the text color of each label when entering and exiting selected mode.
- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
  [super setSelected:selected animated:animated];
  if( selected )
    date.textColor = time.textColor = name.textColor = addr.textColor = prompt.textColor = [UIColor whiteColor];
  else{
    date.textColor = [UIColor darkGrayColor];
    time.textColor = [UIColor darkGrayColor];
    name.textColor = [UIColor blackColor];
    addr.textColor = [UIColor darkGrayColor];
    prompt.textColor = [UIColor darkGrayColor];
  }
}

@end