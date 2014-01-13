//
//  CDAudioFile.h
//  HWforgeekHub3
//
//  Created by Roma on 28.12.13.
//  Copyright (c) 2013 Roma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CDPodcastItem;

@interface CDAudioFile : NSManagedObject

@property (nonatomic, retain) NSString * audioFileURL;
@property (nonatomic, retain) CDPodcastItem *podcastItem;


+ (CDAudioFile *)cdAudioFileWithAudioFileURL:(NSString*)audioFileURL context:(NSManagedObjectContext *)context;

@end
