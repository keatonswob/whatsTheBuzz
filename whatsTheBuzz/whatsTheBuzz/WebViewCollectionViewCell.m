//
//  WebViewCollectionViewCell.m
//  whatsTheBuzz
//
//  Created by Keaton Swoboda on 4/29/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "WebViewCollectionViewCell.h"
#import <WebKit/WebKit.h>

@interface WebViewCollectionViewCell()<WKNavigationDelegate>


@end

@implementation WebViewCollectionViewCell

-(id)init
{
    if (self = [super init])
    {
        WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
        self.webView = [[WKWebView alloc] initWithFrame:self.frame configuration:theConfiguration];
        self.webView.navigationDelegate = self;
        
        
    }
    return  self;
}

-(void)goToWebsite:(NSString *)webUrl
{
    NSURL *nsurl=[NSURL URLWithString: webUrl];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [self.webView loadRequest:nsrequest];
}

@end
