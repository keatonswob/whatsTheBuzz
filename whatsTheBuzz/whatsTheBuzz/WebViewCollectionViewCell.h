//
//  WebViewCollectionViewCell.h
//  whatsTheBuzz
//
//  Created by Keaton Swoboda on 4/29/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface WebViewCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet WKWebView *webView;

-(void)goToWebsite:(NSString *)webUrl;

@end
