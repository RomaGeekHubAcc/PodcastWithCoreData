//
//  CDPodcast.m
//  HWforgeekHub3
//
//  Created by Roma on 28.12.13.
//  Copyright (c) 2013 Roma. All rights reserved.
//

#import "CDPodcast.h"
#import "CDPodcastItem.h"


@implementation CDPodcast

@dynamic podcastImage;
@dynamic podcastTitle;
@dynamic podcastURL;
@dynamic podcastDescription;
@dynamic podcastItems;
@dynamic link;

+ (CDPodcast *)podcastWithLink:(NSString *)link context:(NSManagedObjectContext *)context {
    
    CDPodcast *newPodcast;
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"CDPodcast" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    [fetchRequest setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"link == %@", link];
    [fetchRequest setPredicate:predicate];
    
    NSError *error;
    NSArray *matchingData = [context executeFetchRequest:fetchRequest error:&error];
    
    if (matchingData.count > 0) {
        newPodcast = [matchingData lastObject];
    }
    else {
        newPodcast = [[CDPodcast alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:context];
        newPodcast.link = link;
    }
    
    return newPodcast;
}

@end
