//
//  ResultsTableViewController.m
//  whatsTheBuzz
//
//  Created by Keaton Swoboda on 4/30/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "ResultsTableViewController.h"
#import "WebsiteTableViewCell.h"
#import "BigWebSiteViewController.h"
#import "Bing.h"

@interface ResultsTableViewController ()

@property (nonatomic) NSMutableArray *results;
@property (nonatomic) NSMutableArray *descripResults;
@property (nonatomic) NSMutableArray *sourceResults;
@property (nonatomic) NSString *webUrl;
@property (nonatomic) NSMutableArray *urlResults;
@property (nonatomic) Bing *bing;


@end

@implementation ResultsTableViewController
{
    BOOL whichMethod;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    self.results = [[NSMutableArray alloc] init];
    self.descripResults = [[NSMutableArray alloc] init];
    self.sourceResults = [[NSMutableArray alloc] init];
    self.urlResults = [[NSMutableArray alloc] init];
    
    self.bing = [[Bing alloc] init];
    self.bing.delegate = self;
    [self.bing search:self.queryString];
    whichMethod = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getResults:(NSDictionary *)websites
{
    
    
    NSLog(@"%@", websites);
    NSDictionary *d = [websites objectForKey:@"d"];
    NSArray *results = [d objectForKey:@"results"];
    
    if (results.count == 0)
    {
        [self.bing searchWeb:self.queryString];
        whichMethod = YES;
        
    }
    
    if (whichMethod == NO)
    {
        [self parseNews:results];
    }
    else
    {
       [self parseWeb:results];
    }
    

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.results count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WebsiteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WebsiteCell" forIndexPath:indexPath];
    
    cell.titleLabel.text = self.results[indexPath.row];
    cell.descripLabel.text = self.descripResults[indexPath.row];
    cell.siteNameLabel.text = self.sourceResults[indexPath.row];
    //cell.backgroundColor = [UIColor yellowColor];
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"BigWebsiteSegue"])
    {
        BigWebSiteViewController *bigWebVC = [segue destinationViewController];
        WebsiteTableViewCell *cell = sender;
        NSIndexPath *indexpath = [self.tableView indexPathForCell:cell];
        NSString *urlstring = self.urlResults[indexpath.row];
        bigWebVC.siteUrl = urlstring;
        
        
        
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

-(void)parseNews:(NSArray *)results
{
    
    
    for (NSDictionary *data in results)
    {
        NSString *description = [data objectForKey:@"Description"];
        [self.descripResults addObject:description];
                               
    }
    
    for (NSDictionary *data2 in results)
    {
        NSString *title = [data2 objectForKey:@"Title"];
        [self.results addObject:title];
    }
    
    for (NSDictionary *data3 in results)
    {
        NSString *source = [data3 objectForKey:@"Source"];
        [self.sourceResults addObject:source];
    }
    
    for (NSDictionary *data4 in results)
    {
        NSString *url = [data4 objectForKey:@"Url"];
        [self.urlResults addObject:url];
    }

    [self.tableView reloadData];
}

-(void)parseWeb:(NSArray *)results
{
    
    for (NSDictionary *data in results)
    {
        NSString *description = [data objectForKey:@"Description"];
        [self.descripResults addObject:description];
        
    }
    
    for (NSDictionary *data2 in results)
    {
        NSString *title = [data2 objectForKey:@"Title"];
        [self.results addObject:title];
    }
    
    for (NSDictionary *data4 in results)
    {
        NSString *url = [data4 objectForKey:@"Url"];
        [self.urlResults addObject:url];
    }
    
    [self.tableView reloadData];
    
 
}


@end
