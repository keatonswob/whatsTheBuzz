//
//  WebSiteCollectionViewController.h
//  whatsTheBuzz
//
//  Created by Keaton Swoboda on 4/29/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WebsiteVCDelegate

-(void)getResults:(NSDictionary *)websites;

@end

@interface WebSiteCollectionViewController : UICollectionViewController<WebsiteVCDelegate>

@property (nonatomic) NSString *queryString;
@property (nonatomic) NSString *webUrl;


@end
