//
//  BigWebSiteViewController.m
//  whatsTheBuzz
//
//  Created by Keaton Swoboda on 4/29/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "BigWebSiteViewController.h"
#import <WebKit/WebKit.h>

@interface BigWebSiteViewController ()<WKNavigationDelegate>
{
    NSURL *nsurl;
}

@end

@implementation BigWebSiteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:theConfiguration];
    webView.navigationDelegate = self;
    nsurl=[NSURL URLWithString: self.siteUrl];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [webView loadRequest:nsrequest];
    
    [self.view addSubview:webView];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:YES animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Action Handlers


- (IBAction)shareURL:(UIBarButtonItem *)sender
{
    [self shareText:nil andImage:nil andUrl:nsurl];
}

- (IBAction)favoriteURL:(UIBarButtonItem *)sender
{
    FavArticle *favArticle = [NSEntityDescription insertNewObjectForEntityForName:@"FavArticle" inManagedObjectContext:self.cdStack.managedObjectContext];
    favArticle.url = self.siteUrl;
    favArticle.artDescrip = self.desString;
    favArticle.artName = self.nameString;
    favArticle.source = self.sourceString;
    [self saveCoreDataUpdates];
    
}


- (void)shareText:(NSString *)text andImage:(UIImage *)image andUrl:(NSURL *)url
{
    NSMutableArray *sharingItems = [NSMutableArray new];
    
    if (text) {
        [sharingItems addObject:text];
    }
    if (image) {
        [sharingItems addObject:image];
    }
    if (url) {
        [sharingItems addObject:url];
    }
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:nil];
    [self presentViewController:activityController animated:YES completion:nil];
}
-(void)saveCoreDataUpdates
{
    [self.cdStack saveOrFail:^(NSError *errorOrNil)
     {
         if (errorOrNil)
         {
             NSLog(@"Error from CDStack:%@", [errorOrNil localizedDescription]);
         }
         
     }];
}


@end
