//
//  Downloader.h
//  HWforgeekHub3
//
//  Created by Roma on 02.01.14.
//  Copyright (c) 2014 Roma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Downloader : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, retain) NSMutableData *rssData;


- (void)downloadDataFromPath:(NSString *)path;

@end
