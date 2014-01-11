//
//  CDPodcastItem.m
//  HWforgeekHub3
//
//  Created by Roma on 28.12.13.
//  Copyright (c) 2013 Roma. All rights reserved.
//

#import "CDPodcastItem.h"


@implementation CDPodcastItem

@dynamic itemTitle;
@dynamic itemDescription;
@dynamic itemPubDate;
@dynamic itemAuthhor;
@dynamic itemImage;
@dynamic podcast;
@dynamic audioFiles;
@dynamic guid;

+ (CDPodcastItem *)podcastItemWith_guid:(NSString *)guid context:(NSManagedObjectContext *)context {
    
    CDPodcastItem *newItem;
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"CDPodcastItem" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    [fetchRequest setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"guid == %@", guid];
    [fetchRequest setPredicate:predicate];
    
    NSError *error;
    NSArray *matchingData = [context executeFetchRequest:fetchRequest error:&error];
    
    if (matchingData.count > 0) {
        newItem = [matchingData lastObject];
    }
    else {
        newItem = [[CDPodcastItem alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:context];
        newItem.guid = guid;
    }
    
    return newItem;
}

@end
