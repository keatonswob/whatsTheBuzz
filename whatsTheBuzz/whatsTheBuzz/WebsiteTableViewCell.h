//
//  WebsiteTableViewCell.h
//  whatsTheBuzz
//
//  Created by Keaton Swoboda on 4/30/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebsiteTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *descripLabel;
@property (nonatomic, strong) IBOutlet UILabel *siteNameLabel;

@end
