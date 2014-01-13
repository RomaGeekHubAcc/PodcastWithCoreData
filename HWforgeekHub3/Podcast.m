//
//  Podcast.m
//  HWforgeekHub3
//
//  Created by Roma on 03.12.13.
//  Copyright (c) 2013 Roma. All rights reserved.
//

#import "Podcast.h"
#import "DBManager.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "AppDelegate.h"

@implementation Podcast

+ (NSMutableArray*)getArrayWithPodcastsFromDB {
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    FMDatabase *db = [appDelegate.dbManager getDatabase];
    
    NSMutableArray *arrPodcastsFromBD = [NSMutableArray array];
    FMResultSet *rSet = [db executeQuery:@"SELECT * FROM podcast"];
    while ([rSet next]) {
        Podcast *podcast = [[Podcast alloc]init];
        podcast.podcastTitle = [rSet stringForColumn:@"name"];
        podcast.podcastUrl = [rSet stringForColumn:@"url"];
        podcast.podcastImage = [rSet stringForColumn:@"artwork_url"];
        podcast.podcastDescription = [rSet stringForColumn:@"description"];
        
        [arrPodcastsFromBD addObject:podcast];
    }
    return arrPodcastsFromBD;
}

@end
