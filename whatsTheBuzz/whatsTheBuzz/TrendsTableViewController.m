//
//  TrendsTableViewController.m
//  whatsTheBuzz
//
//  Created by Keaton Swoboda on 4/28/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "TrendsTableViewController.h"
#import "TwitterTrends.h"
#import "STTwitter.h"
#import "ResultsTableViewController.h"
#import "SWRevealViewController.h"
#import "NetworkManager.h"
#import "TrendObject.h"

@interface TrendsTableViewController ()

@property (nonatomic) NSMutableArray *trending;
@property (nonatomic) NSString *queryStrng;
@property (nonatomic) TrendObject *tObj;


@end

@implementation TrendsTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tObj = [[TrendObject alloc] init];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if (revealViewController)
    {
        [self.sideBarButton setTarget:self.revealViewController];
        [self.sideBarButton setAction:@selector(revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    self.trending = [[NSMutableArray alloc] init];
    
    
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TrendCell" forIndexPath:indexPath];
    
    TrendObject *object = self.trending[indexPath.row];
    
    cell.textLabel.text = object.trendString;
    if (object.i == 1)
    {
        <#statements#>
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
        
        UITableViewCell *cell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        NSString *query = self.trending[indexPath.row];
        NSLog(@"%@", query);
        resultsVC.queryString = query;
        
        
    }
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


-(void)addTwitterTrends:(NSMutableArray *)twittTrends
{
    NSLog(@"%@",twittTrends);
    
    for (NSString *trend in twittTrends)
    {
        self.tObj.trendString = trend;
        self.tObj.i = 1;
        [self.trending addObject:self.tObj];
    }

   // [self.trending addObjectsFromArray:twittTrends];
    [self.tableView reloadData];
}

//-(void)addYahooTrends:(NSMutableArray *)yahooTrends
//{
//    NSLog(@"%@", yahooTrends);
//    [self.trending addObjectsFromArray:yahooTrends];
//    [self.tableView reloadData];
//    
//}
//
//-(void)addGoogleTrends:(NSMutableArray *)googleTrends
//{
//    [self.trending addObjectsFromArray:googleTrends];
//    [self.tableView reloadData];
//}






@end
