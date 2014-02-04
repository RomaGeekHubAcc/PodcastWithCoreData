
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


@end
