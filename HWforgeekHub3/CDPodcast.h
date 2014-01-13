//
//  CDPodcast.h
//  HWforgeekHub3
//
//  Created by Roma on 28.12.13.
//  Copyright (c) 2013 Roma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CDPodcastItem;

@interface CDPodcast : NSManagedObject

@property (nonatomic, retain) NSString * podcastImage;
@property (nonatomic, retain) NSString * podcastTitle;
@property (nonatomic, retain) NSString * podcastURL;
@property (nonatomic, retain) NSString * podcastDescription;
@property (nonatomic, retain) NSString *link;
@property (nonatomic, retain) NSOrderedSet *podcastItems;
@end

@interface CDPodcast (CoreDataGeneratedAccessors)

- (void)addPodcastItemsObject:(CDPodcastItem *)value;
- (void)removePodcastItemsObject:(CDPodcastItem *)value;
- (void)addPodcastItems:(NSSet *)values;
- (void)removePodcastItems:(NSSet *)values;

+ (CDPodcast *)podcastWithLink:(NSString *)link context:(NSManagedObjectContext *)context;

@end
