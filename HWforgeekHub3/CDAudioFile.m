//
//  CDAudioFile.m
//  HWforgeekHub3
//
//  Created by Roma on 28.12.13.
//  Copyright (c) 2013 Roma. All rights reserved.
//

#import "CDAudioFile.h"
#import "CDPodcastItem.h"


@implementation CDAudioFile

@dynamic audioFileURL;
@dynamic podcastItem;

+ (CDAudioFile *)cdAudioFileWithAudioFileURL:(NSString*)audioFileURL context:(NSManagedObjectContext *)context {
    CDAudioFile *newAudio;
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"CDAudioFile" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    [fetchRequest setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"audioFileURL == %@", audioFileURL];
    [fetchRequest setPredicate:predicate];
    
    NSError *error;
    NSArray *matchingData = [context executeFetchRequest:fetchRequest error:&error];
    
    if (matchingData.count > 0) {
        newAudio = [matchingData lastObject];
    }
    else {
        newAudio = [[CDAudioFile alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:context];
        newAudio.audioFileURL = audioFileURL;
    }

    return newAudio;
}

@end
