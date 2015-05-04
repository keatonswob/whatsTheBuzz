//
//  Bing.m
//  whatsTheBuzz
//
//  Created by Keaton Swoboda on 4/27/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "Bing.h"
#import "WebSiteCollectionViewController.h"

@interface Bing()<NSURLSessionDataDelegate>
{
    NSMutableData *recieveData;
}

@property NSString *accountKey;
@property NSString *rootUrl;
@property NSString *fullUrl;

@end

@implementation Bing

-(id)init
{
    if (self = [super init])
    {
        busy = NO;
        _accountKey = @"uCGYPtBtCx+XXGL/7OCw0e4Q0Y9gVAVKGPsBP/60Iw4=";
        _rootUrl = @"https://api.datamarket.azure.com/Bing/Search/";

    }
    return  self;
}


- (void)search:(NSString *)queryString
{
    
    
    
    NSString *format = @"json";
    
    NSString *market = @"'en-us'";
    
    NSInteger top = 4;
    
    NSMutableString *fullUri = [NSMutableString stringWithCapacity:256];
    
    [fullUri appendString:_rootUrl];
    
    [fullUri appendFormat:@"News?$format=%@", format];
    
    [fullUri appendFormat:@"&Query='%@'",
     
     [queryString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    [fullUri appendFormat:@"&Market=%@",
     
     [market stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    [fullUri appendFormat:@"&$top=%ld", (long)top];
    
    
    
    [self bingSave:fullUri];
    
    
}

-(void)bingSave:(NSString *)urlStrg
{
    
    NSURL *url = [NSURL URLWithString:urlStrg];
    //    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //  NSData *responseDate = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //    NSDictionary *userInfo = [NSJSONSerialization JSONObjectWithData:responseDate options:NSJSONReadingMutableContainers error:nil];
    //    [self.friends addObject:userInfo];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSString *authStr = [NSString stringWithFormat:@"%@:%@", _accountKey, _accountKey];
    
    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *authValue = [NSString stringWithFormat:@"Basic %@",[authData base64EncodedStringWithOptions:0]];
    configuration.HTTPAdditionalHeaders = @{@"Authorization":authValue};
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url];
    
    [dataTask resume];
    
    //    [self cancel];
}

//-(void)cancel
//{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

#pragma mark - NSURLSession delegate

-(void) URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    completionHandler(NSURLSessionResponseAllow);
}

-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    if (!recieveData)
    {
        recieveData = [[NSMutableData alloc] initWithData:data];
        
    }
    else
    {
        [recieveData setLength:0];
        [recieveData appendData:data];
    }
}

-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (!error)
    {
        NSLog(@"Download Successful.");
        NSDictionary *userInfo = [NSJSONSerialization JSONObjectWithData:recieveData options:0 error:nil];
        //[self.results addObject:userInfo];
        
        [self.delegate getResults:userInfo];
        //[self cancel];
    }
    
    
    
}

- (void)searchWeb:(NSString *)queryString
{
    
    
    
    NSString *format = @"json";
    
    NSString *market = @"'en-us'";
    
    NSInteger top = 4;
    
    NSMutableString *fullUri = [NSMutableString stringWithCapacity:256];
    
    [fullUri appendString:_rootUrl];
    
    [fullUri appendFormat:@"Web?$format=%@", format];
    
    [fullUri appendFormat:@"&Query='%@'",
     
     [queryString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    [fullUri appendFormat:@"&Market=%@",
     
     [market stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    [fullUri appendFormat:@"&$top=%ld", (long)top];
    
    
    [self bingSave:fullUri];
    
    
}




@end
