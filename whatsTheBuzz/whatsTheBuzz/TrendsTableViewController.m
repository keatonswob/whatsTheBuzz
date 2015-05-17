//
//  TrendsTableViewController.m
//  whatsTheBuzz
//
//  Created by Keaton Swoboda on 4/28/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "TrendsTableViewController.h"
#import "ResultsTableViewController.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "TwitterTrends.h"
#import "STTwitter.h"
#import "NetworkManager.h"

#import "TrendTableViewCell.h"
#import "CustomCellBackground.h"          
#import "TrendObject.h"

@interface TrendsTableViewController ()
{
    int k;
    int i;
    BOOL r;
    BOOL go;
    BOOL y;
    BOOL t;
}

@property (nonatomic) NSMutableArray *trending;
@property (nonatomic) NSMutableArray *indexPathArray;
@property (nonatomic) NSMutableArray *googleTrendsArray;
@property (nonatomic) NSMutableArray *yahooTrendsArray;
@property (nonatomic) NSMutableArray *twitterTrendsArray;
@property (nonatomic) NSString *queryStrng;


@end

@implementation TrendsTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIImage *logo = [UIImage imageNamed:@"WTB_LOGO"];
    UIView *headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, 0, 250, 150);
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:logo];
    imgView.frame = CGRectMake(1, 0, 247, 150);
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    
    [headerView addSubview:imgView];
    
    self.navigationItem.titleView = headerView;
  //  self.title  = @"what'sTheBuzz";
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.988 green:0.703 blue:0.191 alpha:1];

    self.yahooTrendsArray = [[NSMutableArray alloc] init];
    self.googleTrendsArray = [[NSMutableArray alloc] init];
    self.twitterTrendsArray = [[NSMutableArray alloc] init];
    self.trending = [[NSMutableArray alloc] init];
    self.indexPathArray = [[NSMutableArray alloc] init];
    
    r = NO;
    go = NO;
    t = NO;
    y = NO;
    
    TwitterTrends *trendy = [[TwitterTrends alloc] init];
    [trendy twitterGet];
    [trendy  searchTwitter:@"biketoworkday2015"];
    
    trendy.delegate = self;
    
    [[NetworkManager sharedNetworkManager] yahooGet];
    [[NetworkManager sharedNetworkManager] googleGet];
    [NetworkManager sharedNetworkManager].delegate = self;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor whiteColor];
    self.refreshControl.tintColor = [UIColor blackColor];
    [self.refreshControl addTarget:self
                            action:@selector(refresh)
                  forControlEvents:UIControlEventValueChanged];
    
    
    
  
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.trending count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TrendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TrendCell" forIndexPath:indexPath];
    
    if (indexPath.row % 2 == 0)
    {
        cell.backgroundColor = [UIColor colorWithRed:0.96 green:0.97 blue:0.96 alpha:1];
    }
    else
    {
        cell.backgroundColor = [UIColor colorWithRed:0.933 green:0.949 blue:0.976 alpha:1];
    }
    
    TrendObject *object = self.trending[indexPath.row];

   cell.TrendLabel.text = object.trendString;
    if (object.i == 1)
    {
        cell.colorView.backgroundColor = [UIColor colorWithRed:.2 green:0.65 blue:0.92 alpha:1];
        cell.sourceLabel.text = @"Twitter";
    }
    else if (object.i == 2)
    {
        cell.colorView.backgroundColor = [UIColor colorWithRed:0.67 green:0.277 blue:0.78 alpha:1];
        cell.sourceLabel.text = @"Yahoo";
    }
    else if (object.i == 3)
    {
        cell.colorView.backgroundColor = [UIColor colorWithRed:0.754 green:0.29 blue:0.308 alpha:1];
        cell.sourceLabel.text = @"Google";
        
    }
   
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ResultsSegue"])
    {
        ResultsTableViewController *resultsVC = [segue destinationViewController];
        
        TrendTableViewCell *cell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        TrendObject *query = self.trending[indexPath.row];
        if ([query.trendString containsString:@"#"])
        {
            NSString *string = query.trendString;
            NSRegularExpression *regexp = [NSRegularExpression
                                           regularExpressionWithPattern:@"([A-Z])([a-z])"
                                           options:0
                                           error:NULL];
            NSString *newString = [regexp
                                   stringByReplacingMatchesInString:string
                                   options:0
                                   range:NSMakeRange(0, string.length)
                                   withTemplate:@" $1$2"];
            query.trendString = newString;
        }
        resultsVC.queryString = query.trendString;
        
        
    }
    if ([segue.identifier isEqualToString:@"FavResultsSegue"])
    {
        ResultsTableViewController *resultsVC = [segue destinationViewController];
        resultsVC.b = YES;
    }
}




-(void)addTwitterTrends:(NSMutableArray *)twittTrends
{
   // NSIndexPath *indexpath = [[NSIndexPath alloc] init];
    
 //   NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    for (i=0; i<twittTrends.count; i++)
    {
        TrendObject *tObj = [[TrendObject alloc] init];
        tObj.trendString = twittTrends[i];
        tObj.i = 1;
        [self.twitterTrendsArray addObject:tObj];
//        int randomRow;
//        if (!self.trending || self.trending.count < 2)
//        {
//            randomRow = 0;
//        }
//        else
//        {
//            randomRow = arc4random_uniform([self.trending count]);
//        }
//        k = 0;
//        [self.trending insertObject:tObj atIndex:k];
//        indexpath = [NSIndexPath indexPathForRow:k inSection:0];
        
//        [self.trending insertObject:tObj atIndex:randomRow];
//        indexpath = [NSIndexPath indexPathForRow:randomRow inSection:0];
        //[self.indexPathArray addObject:indexpath];
//        [self.tableView insertRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationAutomatic];
//        k  = k + 3;
        
    }
   // [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];

//    [self.tableView reloadData];
    t = YES;
    [self fillTableView];
}

-(void)addYahooTrends:(NSMutableArray *)yahooTrends
{
    for (i=0; i<yahooTrends.count; i++)
    {
        TrendObject *tObj = [[TrendObject alloc] init];
        tObj.trendString = yahooTrends[i];
        tObj.i = 2;
        [self.yahooTrendsArray addObject:tObj];
    }
    y = YES;
    [self fillTableView];
}

-(void)addGoogleTrends:(NSMutableArray *)googleTrends
{

    for (i=0; i<googleTrends.count; i++)
    {
        TrendObject *tObj = [[TrendObject alloc] init];
        tObj.trendString = googleTrends[i];
        tObj.i = 3;
        [self.googleTrendsArray addObject:tObj];
    }
    go = YES;
    [self fillTableView];
}

- (void)shuffle:(NSMutableArray *)mutArray
{
    
    for (NSUInteger g = 0; g < mutArray.count; ++g) {
        NSInteger remainingCount = mutArray.count - g;
        NSInteger exchangeIndex = g + arc4random_uniform((u_int32_t )remainingCount);
        [mutArray exchangeObjectAtIndex:g withObjectAtIndex:exchangeIndex];
    }
}

-(void)refresh
{
    [self.trending removeAllObjects];
    [[NetworkManager sharedNetworkManager] yahooGet];
    [[NetworkManager sharedNetworkManager] googleGet];
    TwitterTrends *trendy = [[TwitterTrends alloc] init];
    [trendy twitterGet];
     trendy.delegate = self;
    [self.tableView reloadData];
      [self.refreshControl endRefreshing];
}

- (void)fillTableView
{
    if (go == YES  && y == YES && t == YES)
    {
        for (k = 0; k < 10; k++)
        {
            [self.trending addObject:self.twitterTrendsArray[k]];
            [self.trending addObject:self.googleTrendsArray[k]];
            [self.trending addObject:self.yahooTrendsArray[k]];
        }
        [self.tableView reloadData];
    }
    
}






@end
