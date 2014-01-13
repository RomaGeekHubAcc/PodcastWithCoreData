//
//  Downloader.m
//  HWforgeekHub3
//
//  Created by Roma on 02.01.14.
//  Copyright (c) 2014 Roma. All rights reserved.
//

#import "Downloader.h"

@implementation Downloader

#pragma mark - NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_rssData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"--- didFailWithError - %@", error);
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Nothing was found!"
                                                       message:@"Check your URL and try again " delegate:self cancelButtonTitle:nil otherButtonTitles:@"Cancel", nil];
    [alertView show];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"Podcast downloaded !");
    [[NSNotificationCenter defaultCenter]postNotificationName:@"finishDownloading"object:nil];
}

- (void)downloadDataFromPath:(NSString *)path {
    
    NSURL *url = [NSURL URLWithString:path];
    
    NSURLRequest *request=[NSURLRequest requestWithURL:url
                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                       timeoutInterval:60.0];
    
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:request
                                                                   delegate:self];
    if (theConnection) {
        self.rssData = [NSMutableData data];
        
    }
    else {
        
    }
}

@end
