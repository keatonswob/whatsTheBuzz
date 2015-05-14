//
//  TrendTableViewCell.h
//  whatsTheBuzz
//
//  Created by Keaton Swoboda on 5/6/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrendTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *TrendLabel;
@property (strong, nonatomic) IBOutlet UIView *colorView;
@property (strong, nonatomic) IBOutlet UILabel *sourceLabel;

@end
