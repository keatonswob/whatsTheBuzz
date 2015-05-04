//
//  Facebook.m
//  whatsTheBuzz
//
//  Created by Keaton Swoboda on 5/1/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "NetworkManager.h"

@interface NetworkManager()<NSURLSessionDataDelegate>
{
    NSMutableData *recieveData;
    NSURLSessionConfiguration *configuration;
    NSURLSession *session;
    NSMutableDictionary *receivedDataDict;
}

@end

@implementation NetworkManager

static NSString *googleUrl = @"http://hawttrends.appspot.com/api/terms/";
static NSString *yahooUrl = @"https://www.kimonolabs.com/api/bzfdj3t0?apikey=yknfypffEjjA9GEI723ESgeblVfRqkWM&kimlimit=10";

+ (NetworkManager *)sharedNetworkManager //Singleton Method
{
    static NetworkManager *sharedNetworkManager = nil;
    if (sharedNetworkManager)
        return sharedNetworkManager;
    
    // Use Grand Central Dispatch to only init one instance of NetworkManager, makes the singleton thread-safe
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedNetworkManager = [[NetworkManager alloc] init];
    });
    
    return sharedNetworkManager;
}

 -(instancetype)init
{
    self = [super init];
    if (self)
    {
        configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        receivedDataDict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void)googleGet
{
    NSURL *url = [NSURL URLWithString:googleUrl];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url];
    [self startDataTask:dataTask];
}

-(void)startDataTask:(NSURLSessionDataTask *)dataTask
{
    [receivedDataDict setObject:[[NSMutableData alloc] init] forKey:[NSNumber numberWithInteger:dataTask.taskIdentifier]];
    [dataTask resume];
}
    
#pragma mark - NSURLSession delegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    NSMutableData *receivedData2 = receivedDataDict[[NSNumber numberWithInteger:dataTask.taskIdentifier]];
    [receivedData2 appendData:data];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (!error)
    {
        NSMutableData *receivedData3 = receivedDataDict[[NSNumber numberWithInteger:task.taskIdentifier]];
        NSDictionary *aDictionary = [NSJSONSerialization JSONObjectWithData:receivedData3 options:0 error:nil];
        
        
        if ([[aDictionary objectForKey:@"name"] isEqualToString:@"yahoo Treends"])
        {
            
         //       [self.delegate nextMatchWasFound:upComingMatch];
            
        }
        
        
    }
    
}

@end
