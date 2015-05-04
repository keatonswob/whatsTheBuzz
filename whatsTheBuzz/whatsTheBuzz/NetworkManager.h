//
//  Facebook.h
//  whatsTheBuzz
//
//  Created by Keaton Swoboda on 5/1/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TrendsTableViewController.h"

@interface NetworkManager : NSObject

@property (nonatomic)id<OtherTrendsDelegate> delegate;

+(NetworkManager *)sharedNetworkManager;

-(void)yahooGet;
-(void)googleGet;



@end
