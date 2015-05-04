//
//  TrendsTableViewController.h
//  whatsTheBuzz
//
//  Created by Keaton Swoboda on 4/28/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TwitterTrendsDelegate

-(void)addTwitterTrends:(NSMutableArray *)twittTrends;

@end

@protocol OtherTrendsDelegate

-(void)addOtherTrends:(NSMutableArray *)otherTrends;

@end

@interface TrendsTableViewController : UITableViewController<TwitterTrendsDelegate, OtherTrendsDelegate>

@end
