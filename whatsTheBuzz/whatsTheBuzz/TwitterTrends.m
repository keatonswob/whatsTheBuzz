//
//  TwitterTrends.m
//  whatsTheBuzz
//
//  Created by Keaton Swoboda on 4/28/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "TwitterTrends.h"
#import "STTwitter.h"

@interface TwitterTrends()<NSURLSessionDataDelegate>

@property (nonatomic) NSMutableArray *trending;
@property (nonatomic) NSMutableArray *theTrends;

@end

@implementation TwitterTrends






-(instancetype)init
{
    self = [super init];
    if (self)
    {
        //self.trending = [[NSMutableArray alloc] init];
        self.theTrends = [[NSMutableArray alloc] init];
        
    }
    return self;
}



-(void)twitterGet
{
    STTwitterAPI *twitter = [STTwitterAPI twitterAPIAppOnlyWithConsumerKey:@"a9lK02NkFKAdSOZwvdpLxfSuX" consumerSecret:@"wV7nickdvVQBrqv5Ws1CeakK92REJVCPcUlCTQHPtG7JUfgTui"];
    [twitter verifyCredentialsWithUserSuccessBlock:^(NSString *username, NSString *userID)
     {[twitter getTrendsForWOEID:@"23424977" excludeHashtags:0 successBlock:^(NSDate *asOf, NSDate *createdAt, NSArray *locations, NSArray *trend)
       {
           self.trending = [NSMutableArray arrayWithArray:trend];
           NSLog(@"%@", self.trending);
           [self twitterWasFoundAndParsed];
       }
                      errorBlock:^(NSError *error)
       {
           NSLog(@"%@", error.localizedDescription);
       }];
     }
    errorBlock:^(NSError *error)
    {
        NSLog(@"%@", error.localizedDescription);
    }];
    
   
    
 }

-(void)twitterWasFoundAndParsed
{
    for (NSDictionary *topic in self.trending)
    {
        NSString *name = [topic objectForKey:@"name"];
        [self.theTrends addObject:name];
    }
    
    [self.delegate addTwitterTrends:self.theTrends];
    
}




@end
