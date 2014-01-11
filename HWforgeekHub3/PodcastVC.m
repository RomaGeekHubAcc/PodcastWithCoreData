//
//  PodcastVC.m
//  HWforgeekHub3
//
//  Created by Roma on 13.12.13.
//  Copyright (c) 2013 Roma. All rights reserved.
//

#import "PodcastVC.h"
#import "Podcast.h"
#import "PodcastCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "XMLReader.h"
#import "Reachability.h"
#import "PodcastItemsVC.h"
#import "DBManager.h"
#import "AppDelegate.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "AddPodcastVC.h"
#import "DataManager.h"
#import "CDPodcast.h"

@interface PodcastVC ()

@end

@implementation PodcastVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - viewController's
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    activityIndicator.hidden = YES;
    
    UIBarButtonItem *addButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPodcastAction:)];
    self.navigationItem.rightBarButtonItem = addButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    arrWithPodcasts = [[DataManager sharedDataManager] getAllPodcasts];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
- (void)addPodcastAction:(UIBarButtonItem*)sender {
    AddPodcastVC *addPodcastVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AddPodcastVC"];
    [self.navigationController presentViewController:addPodcastVC animated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrWithPodcasts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PodcastCell";
    PodcastCell *podcastCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Podcast *podcast = [arrWithPodcasts objectAtIndex:indexPath.row];
    
    NSURL *url = [NSURL URLWithString:podcast.podcastImage];
    [podcastCell.imageViewPodcast setImageWithURL:url];
    podcastCell.titleLabelPodcastLabel.text = podcast.podcastTitle;
    podcastCell.descriptionPodcastLabel.text = podcast.podcastDescription;
    
    return podcastCell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CDPodcast *podcast = [arrWithPodcasts objectAtIndex:indexPath.row];
    PodcastItemsVC *podcastItemsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PodcastItemsVC"];
    podcastItemsVC.podcast = podcast;
    [self.navigationController pushViewController:podcastItemsVC animated:YES];
}

#pragma mark - Network Status
+ (NetworkStatus)networkStatus {
    static Reachability *reach = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        reach = [Reachability reachabilityForInternetConnection];
    });
    
    NSLog(@"----Internet status - %@", reach);
    
    return [reach currentReachabilityStatus];
}

- (void)checkNetworkStatus {
    BOOL netStatus = [PodcastVC networkStatus];
    NSLog(@"- Network Status - %d", netStatus);
    if (!netStatus) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"Sorry, network connection is disable. Connect and try again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        alertView.tag = 1;
        [alertView show];
    }
}

@end
