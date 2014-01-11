//
//  PodcastsPlayer.m
//  HWforgeekHub3
//
//  Created by Roma on 09.11.13.
//  Copyright (c) 2013 Roma. All rights reserved.
//

#import "PodcastsPlayerVC.h"
#import "Defines.h"
#import "UIImage+RoundedCorner.h"
#import "PodcastItem.h"
#import <AVFoundation/AVFoundation.h>
#import "AudioPlayer.h"
#import "CDPodcastItem.h"
#import "CDAudioFile.h"

@interface PodcastsPlayerVC ()

@end

@implementation PodcastsPlayerVC

#pragma mark - viewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
//    image = [_podcastItem.image roundedCornerImage:4 borderSize:1];
	podcastImageView.image = image;
    podcastTitleLabel.text = _podcastItem.itemTitle;
    autorLabel.text = _podcastItem.itemAuthhor;
    
    [self createCustomSlider];
    [sliderOutlet setValue:0];
    sliderOutlet.minimumValue = 0;
    
    
    player = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:[[_podcastItem.audioFiles allObjects] objectAtIndex:0]]];
    
    podcastNumber = 0;
    if ([_podcastItem.audioFiles allObjects].count == 1) {
        nextButtonOutlet.enabled = NO;
    }
    
    duration = CMTimeGetSeconds(player.currentItem.duration);
    timingLabel.text = [NSString stringWithFormat:@"00:00:00/%@", [self convertTime:duration]];
    
    
    if (IS_OS_7_OR_LATER) {
#warning розкоментувати
        //        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tabBar.png"] forBarMetrics:UIBarMetricsDefault];
    }
    else {
        sliderOutlet.frame = CGRectMake(sliderOutlet.frame.origin.x, sliderOutlet.frame.origin.y-10, sliderOutlet.frame.size.width, sliderOutlet.frame.size.height);
    }
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCurrentTime) name:@"notifCurrentTime" object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    if (IS_OS_7_OR_LATER) {
        duration = CMTimeGetSeconds(player.currentItem.duration);
        timingLabel.text = [NSString stringWithFormat:@"00:00:00/%@", [self convertTime:duration]];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [player pause];
    player = nil;
    [timer invalidate];
    timer = nil;
    //    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"notifCurrentTime" object:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - actions

- (IBAction)slider:(id)sender {
    CMTime sliderValueTime = CMTimeMakeWithSeconds(sliderOutlet.value, 600);
    [player seekToTime: sliderValueTime];
}

- (IBAction)back15secButton:(id)sender {
    NSInteger time = CMTimeGetSeconds(player.currentItem.currentTime);
    time = time - 15;
    if (time > 0) {
        CMTime newTime = CMTimeMakeWithSeconds(time, 600);
        [player seekToTime: newTime];
    }
    else {
        CMTime newTime = CMTimeMakeWithSeconds(0, 600);
        [player seekToTime: newTime];
    }
}

- (IBAction)playPauseButton:(id)sender {
    if ([player rate] == 0) {
        if (timer) {
            [timer invalidate];
            timer = nil;
        }
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(showCurrentTimeChanging) userInfo:nil repeats:YES];
        if ([player status] == AVPlayerStatusReadyToPlay) {
            [player play];
            
            NSLog(@"----RATE - %f", player.rate);
            duration = CMTimeGetSeconds(player.currentItem.duration);
            NSLog(@"---duration - %f", duration);
        }
        if ([player status] != AVPlayerStatusReadyToPlay) {
            NSLog(@"-----ERROR - %@", player.error);
        }
    }
    else {
        [player pause];
    }
    NSLog(@"----RATE - %f", player.rate);
    duration = CMTimeGetSeconds(player.currentItem.duration);
    NSLog(@"---duration - %f", duration);
}

- (IBAction)nextPodcastButton:(id)sender {
    [player pause];
    player = nil;
    [timer invalidate];
    timer = nil;
    podcastNumber++;
    player = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:[[_podcastItem.audioFiles allObjects] objectAtIndex:podcastNumber]]];
    [player play];
    if (_podcastItem.audioFiles.count == podcastNumber) {
        nextButtonOutlet.enabled = NO;
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(showCurrentTimeChanging) userInfo:nil repeats:YES];
}

#pragma mark - custom

- (NSString*)getSimpleTestPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDirectory = [paths objectAtIndex:0]; // Get documents folder
    NSString *dataPath = [docDirectory stringByAppendingPathComponent:@"audiofle"];
    NSError *error;
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error];
        return dataPath;
    }
    
    return dataPath;
}

- (void)showCurrentTimeChanging {
    
    duration = CMTimeGetSeconds(player.currentItem.duration);
    if (isnan(duration)) {
        duration = 1;
    }
    float currentTime = CMTimeGetSeconds(player.currentItem.currentTime);
    
    sliderOutlet.maximumValue = duration;
    [sliderOutlet setValue:currentTime animated:YES];
    
    timingLabel.text = [NSString stringWithFormat:@"%@/%@", [self convertTime:currentTime], [self convertTime:duration]];
}

-(NSString*)convertTime:(NSUInteger)time{
    
    int h = floor(time / 3600);
    int min = floor(time % 3600 / 60);
    int sec = floor(time % 3600 % 60);
    
    NSString *strH = h >= 10 ? [NSString stringWithFormat:@"%d", h] : [NSString stringWithFormat:@"0%d", h];
    NSString *strMin = min >= 10 ? [NSString stringWithFormat:@"%d", min] : [NSString stringWithFormat:@"0%d", min];
    NSString *strSec = sec >= 10 ? [NSString stringWithFormat:@"%d", sec] : [NSString stringWithFormat:@"0%d", sec];
    
    return [NSString stringWithFormat:@"%@:%@:%@",strH, strMin, strSec];
}

- (void)createCustomSlider {
    
    [sliderOutlet setThumbImage:[UIImage imageNamed:@"sliderHandle.png"] forState:UIControlStateNormal];
    
    [sliderOutlet setMinimumTrackImage:[UIImage imageNamed:@"sliderMin10"] forState:UIControlStateNormal];
    [sliderOutlet setMaximumTrackImage:[UIImage imageNamed:@"sliderMax10"] forState:UIControlStateNormal];
}

- (NSString*)getPathForAudioWithName:(NSString*)name {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cashDirectory = [paths objectAtIndex:0]; // Get documents folder
    NSString *dataPath = [cashDirectory stringByAppendingPathComponent:name];
    
    return dataPath;
}

- (void)repositionViewsIfIOS6 {
    sliderOutlet.frame = CGRectMake(sliderOutlet.frame.origin.x, sliderOutlet.frame.origin.y+toolBarHeigh, sliderOutlet.frame.size.width, sliderOutlet.frame.size.height);
    timingLabel.frame = CGRectMake(timingLabel.frame.origin.x, timingLabel.frame.origin.y+toolBarHeigh, timingLabel.frame.size.width, timingLabel.frame.size.height);
    nextButtonOutlet.frame = CGRectMake(nextButtonOutlet.frame.origin.x, nextButtonOutlet.frame.origin.y+toolBarHeigh, nextButtonOutlet.frame.size.width, nextButtonOutlet.frame.size.height);
    back15secButtonOutlet.frame = CGRectMake(back15secButtonOutlet.frame.origin.x, back15secButtonOutlet.frame.origin.y+toolBarHeigh, back15secButtonOutlet.frame.size.width, back15secButtonOutlet.frame.size.height);
    pauseButtonOutlet.frame = CGRectMake(pauseButtonOutlet.frame.origin.x, pauseButtonOutlet.frame.origin.y+toolBarHeigh, pauseButtonOutlet.frame.size.width, pauseButtonOutlet.frame.size.height);
}


@end
