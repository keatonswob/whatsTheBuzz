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

@end

@implementation ResultsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    self.results = [[NSMutableArray alloc] init];
    self.descripResults = [[NSMutableArray alloc] init];
    self.sourceResults = [[NSMutableArray alloc] init];
    self.urlResults = [[NSMutableArray alloc] init];
    
    Bing *bing = [[Bing alloc] init];
    bing.delegate = self;
    [bing search:self.queryString];
    
    
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
    NSDictionary *data = results[0];
    NSString *descrition1 = [data objectForKey:@"Description"];
    NSString *title1 = [data objectForKey:@"Title"];
    NSString *source1 = [data objectForKey:@"Source"];
    NSDictionary *data2 = results[1];
    NSString *descrition2 = [data2 objectForKey:@"Description"];
    NSString *title2 = [data2 objectForKey:@"Title"];
    NSString *source2 = [data2 objectForKey:@"Source"];
    NSDictionary *data3 = results[2];
    NSString *descrition3 = [data3 objectForKey:@"Description"];
    NSString *title3 = [data3 objectForKey:@"Title"];
    NSString *source3 = [data3 objectForKey:@"Source"];
    NSDictionary *data4 = results[3];
    NSString *descrition4 = [data4 objectForKey:@"Description"];
    NSString *title4 = [data4 objectForKey:@"Title"];
    NSString *source4 = [data4 objectForKey:@"Source"];
    
    [self.results addObject:title1];
    [self.results addObject:title2];
    [self.results addObject:title3];
    [self.results addObject:title4];
    [self.descripResults addObject:descrition1];
    [self.descripResults addObject:descrition2];
    [self.descripResults addObject:descrition3];
    [self.descripResults addObject:descrition4];
    [self.sourceResults addObject:source1];
    [self.sourceResults addObject:source2];
    [self.sourceResults addObject:source3];
    [self.sourceResults addObject:source4];
    
    
    [self.tableView reloadData];
    
   
    NSString *url1 = [data objectForKey:@"Url"];
    NSString *url2 = [data2 objectForKey:@"Url"];
    NSString *url3 = [data3 objectForKey:@"Url"];
    NSString *url4 = [data4 objectForKey:@"Url"];
    
    [self.urlResults addObject:url1];
    [self.urlResults addObject:url2];
    [self.urlResults addObject:url3];
    [self.urlResults addObject:url4];
    

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
    cell.backgroundColor = [UIColor yellowColor];
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


@end
