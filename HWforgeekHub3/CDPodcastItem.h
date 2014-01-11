//
//  CDPodcastItem.h
//  HWforgeekHub3
//
//  Created by Roma on 28.12.13.
//  Copyright (c) 2013 Roma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CDPodcastItem : NSManagedObject

@property (nonatomic, retain) NSString * itemTitle;
@property (nonatomic, retain) NSString * itemDescription;
@property (nonatomic, retain) NSDate * itemPubDate;
@property (nonatomic, retain) NSString * itemAuthhor;
@property (nonatomic, retain) NSString * itemImage;
@property (nonatomic, retain) NSString * guid;
@property (nonatomic, retain) NSManagedObject *podcast;
@property (nonatomic, retain) NSSet *audioFiles;
@end

@interface CDPodcastItem (CoreDataGeneratedAccessors)

- (void)addAudioFilesObject:(NSManagedObject *)value;
- (void)removeAudioFilesObject:(NSManagedObject *)value;
- (void)addAudioFiles:(NSSet *)values;
- (void)removeAudioFiles:(NSSet *)values;

+ (CDPodcastItem *)podcastItemWith_guid:(NSString *)guid context:(NSManagedObjectContext *)context;

@end
