//
//  RSSLoader.m
//  Juan Diego
//
//  Created by Austin Trujillo on 8/2/13.
//  Copyright (c) 2013 ATD. All rights reserved.
//

#import "RSSLoader.h"
#import "GDataXMLNode.h"



@implementation RSSLoader

/*

//      *************
//      * Fetch RSS *
//      *************


-(void)fetchRss
{
    NSLog(@"fetch rss");
    NSData* xmlData = [[NSMutableData alloc] initWithContentsOfURL:[NSURL URLWithString: kRSSUrl] ];
    NSError *error;
    
    GDataXMLDocument* doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:&amp;error];
    
    if (doc != nil) {
        self.loaded = YES;
        
        GDataXMLNode* title = [[[doc rootElement] nodesForXPath:@"channel/title" error:&amp;error] objectAtIndex:0];
        [self.delegate updatedFeedTitle: [title stringValue] ];
        
        NSArray* items = [[doc rootElement] nodesForXPath:@"channel/item" error:&amp;error];
        NSMutableArray* rssItems = [NSMutableArray arrayWithCapacity:[items count] ];
        
        for (GDataXMLElement* xmlItem in items) {
            [rssItems addObject: [self getItemFromXmlElement:xmlItem] ];
        }
        
        [self.delegate performSelectorOnMainThread:@selector(updatedFeedWithRSS:) withObject:rssItems waitUntilDone:YES];
    } else {
        [self.delegate performSelectorOnMainThread:@selector(failedFeedUpdateWithError:) withObject:error waitUntilDone:YES];
    }
    
    [doc autorelease];
    [xmlData release];
}

//      ************************
//      * Get Item XML Element *
//      ************************


-(NSDictionary*)getItemFromXmlElement:(GDataXMLElement*)xmlItem
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            [[[xmlItem elementsForName:@"title"] objectAtIndex:0] stringValue], @"title",
            [[[xmlItem elementsForName:@"link"] objectAtIndex:0] stringValue], @"link",
            [[[xmlItem elementsForName:@"description"] objectAtIndex:0] stringValue], @"description",
            nil];
}

//      ******************************
//      * Dispatch Loading Operation *
//      ******************************


-(void)dispatchLoadingOperation
{
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(fetchRss) object:nil];
    [queue addOperation:operation];
    [operation release];
    [queue autorelease];
}

//      ********
//      * Load *
//      ********


-(void)load
{
    [self dispatchLoadingOperation];
}

*/

@end
