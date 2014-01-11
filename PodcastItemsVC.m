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
//    cell.updatedOutlet.text = list.itemPubDate;
    
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

//#pragma mark - UITextFieldDelegate
//
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    textField.backgroundColor = [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
//    return YES;
//}
//
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
//    textField.backgroundColor = [UIColor whiteColor];
//    return YES;
//}
//
//
//- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//    _textFieldContent = _textField.text;
//    
//    BOOL netStatus = [PodcastItemsVC networkStatus];
//    NSLog(@"- Network Status - %d", netStatus);
//    if (!netStatus) {
//        alertView = [[UIAlertView alloc]initWithTitle:nil message:@"Sorry, network connection is disable. Connect and try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//        alertView.tag = 1;
//        [alertView show];
//    }
//    
//    [textField resignFirstResponder];
//    
//    _activityIndicator. hidden = NO;
//    [_activityIndicator startAnimating];
//    [self.view bringSubviewToFront:_activityIndicator];
//    
//#warning тут я задаю адресу, за якою завантажувати подкаст
//    [self loadDataFromPath:PODCASTS_OTHER];
//    
//    return YES;
//}
//
//#pragma mark - Network Status
//+ (NetworkStatus)networkStatus {
//    static Reachability *reach = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        reach = [Reachability reachabilityForInternetConnection];
//    });
//    
//    NSLog(@"----Internet status - %@", reach);
//    
//    return [reach currentReachabilityStatus];
//}
//
//
//#pragma mark - NSURLConnectionDelegate
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
//    [_rssData appendData:data];
//}
//
//- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
//    NSLog(@"---Error - %@", error);
//}
//
//- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
//    NSString *result = [[NSString alloc] initWithData:_rssData encoding:NSUTF8StringEncoding];
//    NSLog(@"-----Result - %@",result);
//    XMLReader *reader = [[XMLReader alloc]init];
//    _podcast.arrayPodcastItems = [reader parseXMLwithData:_rssData];
//       
//    if (_podcast.arrayPodcastItems.count > 0) {
//        _tableView.hidden = NO;
//        [_activityIndicator stopAnimating];
//        _activityIndicator.hidden = YES;
//        [_tableView reloadData];
//    }
//}
//
//
//#pragma mark - Others
//
//- (void)loadDataFromPath:(NSString *)path {
//    
//    NSURL *url = [NSURL URLWithString:path];
//    
//    NSURLRequest *request=[NSURLRequest requestWithURL:url
//                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
//                                       timeoutInterval:60.0];
//    
//    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:request
//                                                                   delegate:self];
//    if (theConnection) {
//         self.rssData = [NSMutableData data];
//    }
//    
//}


@end
