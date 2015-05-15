//
//  TwitterTrends.h
//  whatsTheBuzz
//
//  Created by Keaton Swoboda on 4/28/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TrendsTableViewController.h"



@interface TwitterTrends : NSObject



@property (nonatomic) NSMutableArray *twitterResults;
@property (nonatomic)id<TwitterTrendsDelegate> delegate;


-(void)twitterGet;
- (void)searchTwitter:(NSString *)query;


@end
