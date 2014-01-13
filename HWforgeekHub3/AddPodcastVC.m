//
//  AddPodcastVC.m
//  HWforgeekHub3
//
//  Created by Roma on 02.01.14.
//  Copyright (c) 2014 Roma. All rights reserved.
//

#import "AddPodcastVC.h"
#import "Downloader.h"
#import "XMLReader.h"
#import "Podcast.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <CoreData/CoreData.h>
#import "DataManager.h"

@interface AddPodcastVC ()

@end

@implementation AddPodcastVC


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - viewCintroller
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    _activityIndicator.hidden = YES;
    
    _textField.delegate = self;
    [self.textField becomeFirstResponder];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dataDownloaded) name:@"finishDownloading" object:nil];
    
    _titleLabel.hidden = YES;
    _descriptionTextView.hidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"finishDownloading" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - textFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self search:nil];
//    _titleLabel.hidden = YES;
//    _descriptionTextView.hidden = YES;
//    
//    [textField resignFirstResponder];
//    [self downloadPodcast];
    return YES;
}

#pragma mark - Actions
- (IBAction)search:(id)sender {
    
    _activityIndicator.hidden = NO;
    [_activityIndicator startAnimating];
    _titleLabel.hidden = YES;
    _descriptionTextView.hidden = YES;
    _imageView.hidden = YES;
    
    [self.textField resignFirstResponder];
    [self downloadPodcast];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addThisPokcast:(id)sender {
    if (!toAddPodcast) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Nothing to add!"
                                                       message:nil
                                                      delegate:self cancelButtonTitle:nil otherButtonTitles:@"Cancel", nil];
        [alert show];
        return;
    }
    else {
        [[DataManager sharedDataManager] insertNewObject:toAddPodcast];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - custom
- (void)dataDownloaded {
    NSLog(@"Data downloaded");
    rssData = downloader.rssData;
    
    if (rssData) {
        XMLReader *xmlReader = [[XMLReader alloc]init];
        toAddPodcast = [xmlReader parseXMLwithData:rssData];
        
        if (toAddPodcast) {
            
            if (toAddPodcast.podcastTitle ) {
                [_activityIndicator stopAnimating];
                _activityIndicator.hidden = YES;
                _descriptionTextView.hidden = NO;
                _titleLabel.hidden = NO;
                _imageView.hidden = NO;
                
                [_imageView setImageWithURL:[NSURL URLWithString:toAddPodcast.podcastImage]];
                _titleLabel.text = toAddPodcast.podcastTitle;
                _descriptionTextView.text = toAddPodcast.podcastDescription;
            }
            else {
                NSLog(@"Podcast empty");
                
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Nothing was found!"
                                                                   message:@"Check your URL and try again " delegate:self cancelButtonTitle:nil otherButtonTitles:@"Cancel", nil];
                [alertView show];
            }
        }
    }
}

- (void)downloadPodcast {
    if (!downloader) {
        downloader = [[Downloader alloc]init];
    }
    [downloader downloadDataFromPath:_textField.text];
}

@end
