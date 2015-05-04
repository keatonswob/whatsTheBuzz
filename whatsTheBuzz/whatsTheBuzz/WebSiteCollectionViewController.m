//
//  WebSiteCollectionViewController.m
//  whatsTheBuzz
//
//  Created by Keaton Swoboda on 4/29/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "WebSiteCollectionViewController.h"
#import "WebViewCollectionViewCell.h"
#import "BigWebSiteViewController.h"
#import "Bing.h"

@interface WebSiteCollectionViewController ()

@property (nonatomic) NSMutableArray *webResults;

@end

@implementation WebSiteCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    self.webResults = [[NSMutableArray alloc] init];
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"WebCell"];
    
    Bing *bing = [[Bing alloc] init];
   // bing.delegate = self;
    //[bing search:self.queryString];
    
    
    
    // Do any additional setup after loading the view.
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
    NSString *url1 = [data objectForKey:@"Url"];
    NSLog(@"%@", url1);
    NSDictionary *data2 = results[1];
    NSString *url2 = [data2 objectForKey:@"Url"];
    NSDictionary *data3 = results[2];
    NSString *url3 = [data3 objectForKey:@"Url"];
    NSDictionary *data4 = results[3];
    NSString *url4 = [data4 objectForKey:@"Url"];
    
    
    self.webUrl = url1;
    [self.webResults addObject:self.webUrl];
    [self.webResults addObject:url2];
    [self.webResults addObject:url3];
    [self.webResults addObject:url4];
    [self.collectionView reloadData];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
     return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.webResults count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WebViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WebCell" forIndexPath:indexPath];
    
    [cell goToWebsite:self.webResults[indexPath.row]];
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"FullPageSegue"])
    {
       BigWebSiteViewController *bigWebSiteVC = [segue destinationViewController];
        
        WebViewCollectionViewCell *cell = sender;
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
        NSString *webSite = self.webResults[indexPath.row];
        NSLog(@"%@", webSite);
        bigWebSiteVC.siteUrl = webSite;
        
        
    }
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
