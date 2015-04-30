//
//  Bing.h
//  whatsTheBuzz
//
//  Created by Keaton Swoboda on 4/27/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebSiteCollectionViewController.h"

@interface Bing : NSObject
{
    NSMutableData *responseData;
    BOOL busy;
    BOOL isTitle;
}
@property (nonatomic) NSMutableArray *results;
@property (nonatomic)id<WebsiteVCDelegate> delegate;


- (id) init;
- (void)search:(NSString *)queryString;

@end
