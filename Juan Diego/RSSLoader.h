//
//  RSSLoader.h
//  Juan Diego
//
//  Created by Austin Trujillo on 8/2/13.
//  Copyright (c) 2013 ATD. All rights reserved.
//

/*

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"
#define kRSSUrl @"http://feeds.feedburner.com/TouchCodeMagazine"

@protocol RSSLoaderDelegate
@required
-(void)updatedFeedWithRSS:(NSArray*)items;
-(void)failedFeedUpdateWithError:(NSError*)error;
-(void)updatedFeedTitle:(NSString*)title;
@end

*/
 
@interface RSSLoader : NSObject

/*

{
    UIViewController<RSSLoaderDelegate> * delegate;
    BOOL loaded;
}

@property (retain, nonatomic) UIViewController<RSSLoaderDelegate> * delegate;
@property (nonatomic, assign) BOOL loaded;

-(void)load;

*/
 
@end
