//
//  Podcast.h
//  HWforgeekHub3
//
//  Created by Roma on 03.12.13.
//  Copyright (c) 2013 Roma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Podcast : NSObject

@property (nonatomic) NSMutableArray *arrayPodcastItems;
@property (nonatomic) NSString *podcastImage;
@property (nonatomic) NSString *podcastTitle;
@property (nonatomic) NSString *podcastUrl;
@property (nonatomic) NSString *podcastDescription;
@property (nonatomic) NSString *link;


+ (NSMutableArray*)getArrayWithPodcastsFromDB;

@end
