//
//  ResultsTableViewController.h
//  whatsTheBuzz
//
//  Created by Keaton Swoboda on 4/30/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ResultsVCDelegate

-(void)getResults:(NSDictionary *)websites;


@end

@interface ResultsTableViewController : UITableViewController<ResultsVCDelegate>

@property (nonatomic) NSString *queryString;

@end
