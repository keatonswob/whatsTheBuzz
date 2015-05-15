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
#import "CustomCellBackground.h"
#import "CstmResultCellBackground.h"
#import "FavResultCellBackground.h"
#import "CoreDataStack.h"
#import "FavArticle.h"
#import <QuartzCore/QuartzCore.h>

@interface ResultsTableViewController ()
{
    CoreDataStack *cdStack;
    NSMutableArray *items;
}


@property (nonatomic) NSMutableArray *results;
@property (nonatomic) NSMutableArray *descripResults;
@property (nonatomic) NSMutableArray *sourceResults;
@property (nonatomic) NSString *webUrl;
@property (nonatomic) NSMutableArray *urlResults;
@property (nonatomic) NSMutableArray *urlImages;
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
    
    
    cdStack = [CoreDataStack coreDataStackWithModelName:@"FavModel"];
    cdStack.coreDataStoreType = CDSStoreTypeSQL;
    
    items = [[NSMutableArray alloc] init];
    self.results = [[NSMutableArray alloc] init];
    self.descripResults = [[NSMutableArray alloc] init];
    self.sourceResults = [[NSMutableArray alloc] init];
    self.urlResults = [[NSMutableArray alloc] init];
    self.urlImages = [[NSMutableArray alloc] init];
    
    if (self.b == NO)
    {
        self.bing = [[Bing alloc] init];
        self.bing.delegate = self;
        [self.bing search:self.queryString];
        whichMethod = NO;
    }
   
    
    
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.b == YES)
    {
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"FavArticle" inManagedObjectContext:cdStack.managedObjectContext];
        NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
        fetch.entity = entity;
        items = nil;
        items = [[cdStack.managedObjectContext executeFetchRequest:fetch error:nil] mutableCopy];
        [self.tableView reloadData];
        
    }
}

-(void)getResults:(NSDictionary *)websites
{
    
    
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
    if (self.b == NO)
    {
        return [self.results count];
    }
    else
    {
        return [items count];
    }
    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WebsiteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WebsiteCell" forIndexPath:indexPath];
    
    
    if (self.b == NO)
    {

        
        cell.titleLabel.text = self.results[indexPath.row];
        cell.descripLabel.text = self.descripResults[indexPath.row];
        cell.siteNameLabel.text = self.sourceResults[indexPath.row];
        cell.siteNameLabel.backgroundColor = [UIColor clearColor];
       // cell.siteNameLabel.layer.cornerRadius = 5;
       // cell.siteNameLabel.layer.borderWidth = 1;
        
        
        
    }
    
    else if (self.b == YES)
    {

    
   
    
        FavArticle *article = items[indexPath.row];
        cell.titleLabel.text = article.artName;
        cell.descripLabel.text = article.artDescrip;
        cell.siteNameLabel.text = article.source;
        [self.urlResults addObject:article.url];
    }
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
        if (self.b == NO)
        {
        NSString *nameString = self.results[indexpath.row];
        NSString *desString = self.descripResults[indexpath.row];
        NSString *sourceString = self.sourceResults[indexpath.row];
        bigWebVC.nameString = nameString;
        bigWebVC.sourceString = sourceString;
        bigWebVC.desString = desString;
        }
        bigWebVC.siteUrl = urlstring;
        bigWebVC.cdStack = cdStack;
        bigWebVC.b = self.b;
        if (self.b == YES)
        {
            FavArticle *article = items[indexpath.row];
            bigWebVC.article = article;
            

        }
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
