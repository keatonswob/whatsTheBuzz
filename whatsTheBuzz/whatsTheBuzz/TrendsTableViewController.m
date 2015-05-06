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
#import "TrendObject.h"

@interface TrendsTableViewController ()
{
    int i;
    BOOL r;
}

@property (nonatomic) NSMutableArray *trending;
@property (nonatomic) NSString *queryStrng;


@end

@implementation TrendsTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.center = self.view.center;
    [self.view addSubview:loginButton];
    
//    SWRevealViewController *revealViewController = self.revealViewController;
//    if (revealViewController)
//    {
//        [self.sideBarButton setTarget:self.revealViewController];
//        [self.sideBarButton setAction:@selector(revealToggle: )];
//        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
//    }
    
    self.trending = [[NSMutableArray alloc] init];
    
    r = NO;
    
    TwitterTrends *trendy = [[TwitterTrends alloc] init];
    [trendy twitterGet];
    
    trendy.delegate = self;
    
    [[NetworkManager sharedNetworkManager] yahooGet];
    [[NetworkManager sharedNetworkManager] googleGet];
    [NetworkManager sharedNetworkManager].delegate = self;
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
   
    
        [self shuffle:self.trending];
    
    
    TrendObject *object = self.trending[indexPath.row];

   cell.TrendLabel.text = object.trendString;
    if (object.i == 1)
    {
        cell.cellColorView.backgroundColor = [UIColor blueColor];
    }
    else if (object.i == 2)
    {
        cell.cellColorView.backgroundColor = [UIColor redColor];
    }
    else if (object.i == 3)
    {
        cell.cellColorView.backgroundColor = [UIColor greenColor];
    }
   
    
    return cell;
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ResultsSegue"])
    {
        ResultsTableViewController *resultsVC = [segue destinationViewController];
        
        TrendTableViewCell *cell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        TrendObject *query = self.trending[indexPath.row];
        NSLog(@"%@", query);
        resultsVC.queryString = query.trendString;
        
        
    }
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


-(void)addTwitterTrends:(NSMutableArray *)twittTrends
{
    NSLog(@"%@",twittTrends);
    
    
    for (i=1; i<twittTrends.count; i++)
    {
        TrendObject *tObj = [[TrendObject alloc] init];
        tObj.trendString = twittTrends[i];
        tObj.i = 1;
        [self.trending addObject:tObj];
    }

    [self.tableView reloadData];
}

-(void)addYahooTrends:(NSMutableArray *)yahooTrends
{
    NSLog(@"%@", yahooTrends);
    
    for (i=1; i<yahooTrends.count; i++)
    {
        TrendObject *tObj = [[TrendObject alloc] init];
        tObj.trendString = yahooTrends[i];
        tObj.i = 2;
        [self.trending addObject:tObj];
    }
    
   
    
    [self.tableView reloadData];
    
}

-(void)addGoogleTrends:(NSMutableArray *)googleTrends
{
    
    for (i=1; i<googleTrends.count; i++)
    {
        TrendObject *tObj = [[TrendObject alloc] init];
        tObj.trendString = googleTrends[i];
        tObj.i = 3;
        [self.trending addObject:tObj];
    }
    [self.tableView reloadData];
}

- (void)shuffle:(NSMutableArray *)mutArray
{
    
    for (NSUInteger g = 0; g < mutArray.count; ++g) {
        NSInteger remainingCount = mutArray.count - g;
        NSInteger exchangeIndex = g + arc4random_uniform((u_int32_t )remainingCount);
        [mutArray exchangeObjectAtIndex:g withObjectAtIndex:exchangeIndex];
    }
}





@end
