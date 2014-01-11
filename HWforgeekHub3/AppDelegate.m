
//  AppDelegate.m
//  HWforgeekHub3
//
//  Created by Roma on 27.10.13.
//  Copyright (c) 2013 Roma. All rights reserved.
//

#import "AppDelegate.h"
#import "Defines.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "DBManager.h"
#import "Podcast.h"
#import "DataManager.h"



@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    [self setupAppearance];
    _dbManager = [[DBManager alloc]init];
    
    FMDatabase *db = [_dbManager getDatabase];
    FMResultSet *resultSet = [db executeQuery:@"SELECT COUNT(*) FROM podcast"];
    int totalCount = 0;
    if ([resultSet next]) {
        totalCount = [resultSet intForColumnIndex:0];
    }
    
    if (totalCount >0) {
        _arrayWithPodcasts = [Podcast getArrayWithPodcastsFromDB];
    }
    else {
        [self setPodcastsToDatabaseIfEmpty];
    }

    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - customMethods
-(void)setupAppearance {
    
    //    UIImage *sliderLeftTrackImage = [[UIImage imageNamed: @"sliderMin.png"] stretchableImageWithLeftCapWidth: 6 topCapHeight: 0];
    //    UIImage *sliderRightTrackImage = [[UIImage imageNamed: @"sliderMax.png"] stretchableImageWithLeftCapWidth: 0 topCapHeight: 0];
    //    [[UISlider appearance]  setMinimumTrackImage: sliderLeftTrackImage forState: UIControlStateNormal];
    //    [[UISlider appearance]  setMaximumTrackImage: sliderRightTrackImage forState: UIControlStateNormal];
    
    
    UIImage *minImage = [[UIImage imageNamed:@"sliderMin.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(9,5,7,5)];
    UIImage *maxImage = [[UIImage imageNamed:@"sliderMax.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,0,0,5)];
    UIImage *thumbImage = [UIImage imageNamed:@"sliderHandle@2x.png"];
    
    [[UISlider appearance] setMaximumTrackImage:maxImage forState:UIControlStateNormal];
    [[UISlider appearance] setMinimumTrackImage:minImage forState:UIControlStateNormal];
    [[UISlider appearance] setThumbImage:thumbImage forState:UIControlStateNormal];
}

- (void)fillArrayWithPodcasts {
    
    Podcast *p1 = [[Podcast alloc]init];
    p1.podcastImage = @"http://s.rpod.ru/data/users_avatars/00/00/00/22/37/ava_ava_1153664433.jpg";
    p1.podcastTitle = @"Автомобили";
    p1.podcastDescription = @"Всё о том, что ездит по земле! Автомобили, трактора, квадроциклы, мотоциклы и мопеды - все, на чем можно ездить!";
    p1.podcastUrl = PODCASTS_OTHER;
    
    Podcast *p2 = [[Podcast alloc]init];
    p2.podcastImage = @"http://s.rpod.ru/data/users_avatars/00/00/00/01/00/ava_ava_1152288228.jpg";
    p2.podcastTitle = @"Cпорт";
    p2.podcastDescription = @"";
    p2.podcastUrl = PODCASTS_SPORT;
    
    Podcast *p3 = [[Podcast alloc]init];
    p3.podcastImage = @"http://s.rpod.ru/data/users_avatars/00/00/03/47/40/ava_ava_1269430346.jpg";
    p3.podcastTitle = @"2Гига";
    p3.podcastDescription = @"Регулярный подкаст о наиболее интересных моментах в IT-индустрии и мире за прошедшую неделю.";
    p3.podcastUrl = PODCAST_GADGET;
    
    Podcast *p4 = [[Podcast alloc]init];
    p4.podcastImage = @"http://s.rpod.ru/data/users_avatars/00/00/04/24/25/238801_dinner_with_candles_in_the_gar.jpg";
    p4.podcastTitle = @"Поздний ужин с Kate";
    p4.podcastDescription = @"";
    p4.podcastUrl = PODCASTS_ABOUT_MEMORY;
    
    Podcast *p5 = [[Podcast alloc]init];
    p5.podcastImage = @"http://s.rpod.ru/data/users_avatars/00/00/02/13/67/images.jpg";
    p5.podcastTitle = @"Football Show";
    p5.podcastDescription = @"";
    p5.podcastUrl = PODCAST_FOOTBALL;
    _arrayWithPodcasts = [NSArray arrayWithObjects:p1, p2, p3,p4, p5, nil];
    
    for (Podcast*podcast in _arrayWithPodcasts) {
        [[DataManager sharedDataManager] insertNewObject:podcast];
    }
}


- (void)setPodcastsToDatabaseIfEmpty {
    
    FMDatabase *db = [_dbManager getDatabase];
    
    [self fillArrayWithPodcasts];
    
    for (Podcast *podcast in _arrayWithPodcasts) {
        NSMutableArray *podcAr = [NSMutableArray array];
        [podcAr addObject:podcast.podcastTitle];
        [podcAr addObject:podcast.podcastUrl];
        [podcAr addObject:podcast.podcastImage];
        [podcAr addObject:podcast.podcastDescription];
        
        BOOL isInsertOk = [db executeUpdate:@"INSERT INTO podcast (name, url, artwork_url, description) VALUES(?,?,?,?)"withArgumentsInArray:podcAr];
        
        if(!isInsertOk) {
            NSLog(@"-- Failed to Insert - %@", [db lastError]);
        }
    }
}


@end
