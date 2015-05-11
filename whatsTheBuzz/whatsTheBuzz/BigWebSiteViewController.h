//
//  BigWebSiteViewController.h
//  whatsTheBuzz
//
//  Created by Keaton Swoboda on 4/29/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FavArticle.h"
#import "CoreDataStack.h"

@interface BigWebSiteViewController : UIViewController

@property(nonatomic, strong) CoreDataStack *cdStack;
@property (nonatomic) NSString *siteUrl;
@property (nonatomic) NSString *nameString;
@property (nonatomic) NSString *desString;
@property (nonatomic) NSString *sourceString;

@end
