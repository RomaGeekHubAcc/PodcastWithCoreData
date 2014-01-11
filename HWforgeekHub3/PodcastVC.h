//
//  PodcastVC.h
//  HWforgeekHub3
//
//  Created by Roma on 13.12.13.
//  Copyright (c) 2013 Roma. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Podcast;

@interface PodcastVC : UITableViewController
{
    NSArray *arrWithPodcasts;
    __weak IBOutlet UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic) Podcast *selectedPodcast;
@property (nonatomic, retain) NSMutableData *rssData;

@end
