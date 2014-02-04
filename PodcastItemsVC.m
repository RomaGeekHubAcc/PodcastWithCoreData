//
//  StartVC.m
//  HWforgeekHub3
//
//  Created by Roma on 27.10.13.
//  Copyright (c) 2013 Roma. All rights reserved.
//


#import <SDWebImage/UIImageView+WebCache.h>
#import "Reachability.h"
#import "PodcastItemsVC.h"
#import "PodcastItemCell.h"
#import "PodcastItem.h"
#import "Podcast.h"
#import "DetailVC.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <CoreFoundation/CoreFoundation.h>
#import "XMLReader.h"
#import "Defines.h"
#import "CDPodcast.h"
#import "CDPodcastItem.h"
#import "Utilities.h"

@interface PodcastItemsVC ()

@end

@implementation PodcastItemsVC

#pragma mark -viewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Podcast Items";
	
    countTegsWithImage = 0;
    _tableView.hidden = NO;
    _activityIndicator.hidden = YES;
    _tableView.backgroundColor = [UIColor lightGrayColor];
    
    _arrayWithCDPodcastItems = [_podcast.podcastItems allObjects];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    NSLog(@"touchesBegan:withEvent:");
//    [self.view endEditing:YES];
//    [super touchesBegan:touches withEvent:event];
//}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrayWithCDPodcastItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    PodcastItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[PodcastItemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    CDPodcastItem *list = [_arrayWithCDPodcastItems objectAtIndex:indexPath.row];
    
    cell.titleOutlet.text = list.itemTitle;
    cell.updatedOutlet.text = [Utilities humanReadableFromDate:list.itemPubDate];
    
    NSURL *url = [NSURL URLWithString:list.itemImage];
    [cell.imgView setImageWithURL:url];

    
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailVC *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
    detailVC.list = [_arrayWithCDPodcastItems objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:detailVC animated:YES];
}


@end
