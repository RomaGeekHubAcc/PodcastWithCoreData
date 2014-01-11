//
//  DataManager.h
//  HWforgeekHub3
//
//  Created by Roma on 28.12.13.
//  Copyright (c) 2013 Roma. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Podcast;

@interface DataManager : NSObject


- (NSArray*)getAllPodcasts;
+ (DataManager*)sharedDataManager;
- (void)insertNewObject:(Podcast*)podcast;

@end
